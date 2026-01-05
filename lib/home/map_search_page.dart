import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_tutorial/widgets/map_view.dart';
import 'package:flutter_tutorial/widgets/voice_button.dart';
import 'package:flutter_tutorial/widgets/search_bar.dart';

class MapSearchPage extends StatefulWidget {
  const MapSearchPage({super.key});

  @override
  State<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final MapController _mapController = MapController();

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
            // 🔹 검색창
            CustomSearchBar(
              controller: _controller,
              hint: "목적지를 입력하세요"
            ),
            const SizedBox(height: 12),

            // 음성 입력 버튼 (VoiceButton 사용)
            VoiceButton(
              onResult: (text) {
                setState(() {
                  _controller.text = text; // 음성 인식 결과를 검색창에 반영
                });
              },
            ),

            // 🔹 검색 실행 버튼
            ElevatedButton(
              onPressed: _searchDestination,
              child: const Text("검색 시작"),
            ),
            const SizedBox(height: 16),

            // 지도
            Expanded(
              child: MapView(
                mapController: _mapController,
                center: _currentPosition ?? LatLng(37.5665, 126.9780),
                markers: _markers,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
