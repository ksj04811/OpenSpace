import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapSearchPage extends StatefulWidget {
  const MapSearchPage({super.key});

  @override
  State<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {
  final SpeechToText _speech = SpeechToText();
  final TextEditingController _controller = TextEditingController();
  final MapController _mapController = MapController(); // 지도 컨트롤러

  bool _isListening = false;
  String _statusText = "음성 입력 준비";

  /// 음성 인식 시작
  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        setState(() {
          _statusText = "상태: $status";
        });
      },
      onError: (error) {
        setState(() {
          _statusText = "오류: ${error.errorMsg}";
        });
      },
    );

    if (available) {
      setState(() => _isListening = true);

      await _speech.listen(
        localeId: "ko_KR",
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });
        },
      );
    }
  }

  /// 음성 인식 중지
  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  /// 검색 실행 (나중에 길찾기 서버 연결 가능)
  void _searchDestination() {
    String destination = _controller.text.trim();
    if (destination.isNotEmpty) {
      // TODO: 서버 연동 시 목적지 좌표 받아서 지도 이동
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("검색 실행: \"$destination\"")),
      );

      // 임시: 지도 중앙 이동 (서울 중심)
      _mapController.move(LatLng(37.5665, 126.9780), 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("목적지 검색"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 검색창
            Semantics(
              textField: true,
              label: "목적지 입력창",
              hint: "음성 또는 키보드로 목적지를 입력할 수 있습니다",
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "목적지를 입력하세요",
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 음성 입력 버튼
            Semantics(
              button: true,
              label: _isListening
                  ? "음성 입력 중지 버튼"
                  : "음성으로 목적지 입력 버튼",
              hint: "두 번 탭하면 음성 입력을 시작/중지합니다",
              child: ElevatedButton(
                onPressed:
                    _isListening ? _stopListening : _startListening,
                child: Text(
                  _isListening ? "듣는 중..." : "음성 입력 시작",
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 검색 실행 버튼
            Semantics(
              button: true,
              label: "검색 실행 버튼",
              hint: "두 번 탭하면 입력한 목적지로 검색을 시작합니다",
              child: ElevatedButton(
                onPressed: _searchDestination,
                child: const Text("검색 시작"),
              ),
            ),

            const SizedBox(height: 16),

            // 지도
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(37.5665, 126.9780),
                  zoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.yourapp',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
