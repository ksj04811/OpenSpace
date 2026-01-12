import 'package:flutter/material.dart';

/// 검색창 컴포넌트 (네모형, 다른 버튼들과 통일)
class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String semanticLabel;
  final String hint;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.semanticLabel = "검색창",
    this.hint = "어디로 갈까요?",
  });

  static const double _radius = 8; // 🔹 다른 버튼들과 동일

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: semanticLabel,
      hint: hint,
      child: Container(
        height: 48, // 🔹 VoiceButton / SearchButton과 동일 높이
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_radius),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Color(0xFF001F3F),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "어디로 갈까요?",
                  border: InputBorder.none, // 🔹 입력 시 테두리 제거
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
      ),
    );
  }
}
