import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapSearchPage extends StatefulWidget {
  const MapSearchPage({super.key});

  @override
  State<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {
  final SpeechToText _speech = SpeechToText();
  final TextEditingController _controller = TextEditingController();
  final MapController _mapController = MapController();

  bool _isListening = false;
  String _statusText = "음성 입력 준비";

  LatLng? _currentPosition;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  /// 현재 위치 가져오기
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);

      // Flutter_map 6.1.0 호환 마커
      _markers = [
        Marker(
          point: _currentPosition!,
          width: 40,
          height: 40,
          child: const Icon(
            Icons.my_location,
            color: Colors.blue,
             size: 40,
          ),
        ),
      ];


      // 지도 중심 이동
      _mapController.move(_currentPosition!, 17);
    });
  }

  /// 음성 인식 시작
  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        setState(() => _statusText = "상태: $status");
      },
      onError: (error) {
        setState(() => _statusText = "오류: ${error.errorMsg}");
      },
    );

    if (available) {
      setState(() => _isListening = true);
      await _speech.listen(
        localeId: "ko_KR",
        onResult: (result) {
          setState(() => _controller.text = result.recognizedWords);
        },
      );
    }
  }

  /// 음성 인식 중지
  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  /// 검색 실행 (임시: 서울 중심 이동)
  void _searchDestination() {
    String destination = _controller.text.trim();
    if (destination.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("검색 실행: \"$destination\"")),
      );

      // 임시로 지도 이동
      _mapController.move(LatLng(37.5665, 126.9780), 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("목적지 검색")),
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
                onPressed: _isListening ? _stopListening : _startListening,
                child: Text(_isListening ? "듣는 중..." : "음성 입력 시작"),
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
                  center: _currentPosition ?? LatLng(37.5665, 126.9780),
                  zoom: 15.0,
                  interactiveFlags: InteractiveFlag.all,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.yourapp',
                  ),

                  // Flutter_map 6.1.0 호환 MarkerLayer
                  if (_markers.isNotEmpty) MarkerLayer(markers: _markers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
