import 'package:flutter/material.dart';

/// 검색창 컴포넌트 (네모형 + 음성 인식 네온 펄스)
class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final bool isListening;
  final String semanticLabel;
  final String hint;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.isListening = false,
    this.semanticLabel = "검색창",
    this.hint = "어디로 갈까요?",
  });

  static const double radius = 8;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _pulse = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    if (widget.isListening) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant CustomSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isListening && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isListening && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: widget.semanticLabel,
      hint: widget.hint,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, child) {
          return Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(CustomSearchBar.radius),
              boxShadow: widget.isListening
                  ? [
                      // 🌟 내부에 가까운 선명한 노랑
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.45),
                        blurRadius: 10 * _pulse.value,
                        spreadRadius: 1.2 * _pulse.value,
                      ),
                      // 🌟 바깥으로 퍼지며 투명해지는 빛
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.15),
                        blurRadius: 22 * _pulse.value,
                        spreadRadius: 3.5 * _pulse.value,
                      ),
                    ]
                  : [],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: widget.isListening
                      ? Colors.amber
                      : const Color(0xFF001F3F),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF001F3F),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
