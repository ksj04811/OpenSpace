import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:latlong2/latlong.dart';

/// 검색 버튼: 검색 실행 + 효과음 + TTS
class SearchButton extends StatefulWidget {
  final TextEditingController controller;
  final MapController mapController;

  const SearchButton({
    super.key,
    required this.controller,
    required this.mapController,
  });

  @override
  State<SearchButton> createState() => SearchButtonState();
}

class SearchButtonState extends State<SearchButton> {
  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _player = AudioPlayer();

  bool _isSearching = false; // ✅ 여기서 선언

  /// 외부에서도 호출 가능하게 만든 자동 검색 메서드
  void triggerSearch() {
    _onPressed(); // ✅ State 내부 메서드
  }

  Future<void> _onPressed() async {
    String destination = widget.controller.text.trim();
    if (destination.isEmpty) return;

    setState(() => _isSearching = true);

    await _player.play(AssetSource('sounds/Alert2.wav'));
    await _tts.speak("검색 중입니다");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("검색 실행: \"$destination\"")),
    );

    widget.mapController.move(const LatLng(37.5665, 126.9780), 15.0);

    setState(() => _isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(
          _isSearching ? Icons.search : Icons.search_outlined,
          color: const Color(0xFF001F3F),
          size: 24,
        ),
        onPressed: _onPressed, // ✅ State 내부 메서드 참조
      ),
    );
  }
}
