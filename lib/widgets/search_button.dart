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

  /// 외부에서도 호출 가능하게 만든 자동 검색 메서드
  void triggerSearch() {
    _searchDestination();
  }

  Future<void> _searchDestination() async {
    String destination = widget.controller.text.trim();
    if (destination.isEmpty) return;

    // 🔊 효과음
    await _player.play(AssetSource('sounds/Alert2.wav'));

    // 🔊 TTS
    await _tts.speak("검색 중입니다");

    // 🔹 실제 검색 로직
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("검색 실행: \"$destination\"")),
    );

    widget.mapController.move(const LatLng(37.5665, 126.9780), 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _searchDestination,
      child: const Text("검색 시작"),
    );
  }
}
