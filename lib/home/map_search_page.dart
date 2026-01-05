import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_tutorial/widgets/map_view.dart';
import 'package:flutter_tutorial/widgets/voice_button.dart';
import 'package:flutter_tutorial/widgets/search_button.dart';
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

  final GlobalKey<SearchButtonState> _searchKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentPosition!, 17);

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
    });
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
              hint: "목적지를 입력하세요",
            ),
            const SizedBox(height: 12),

            // 🔹 음성 입력 버튼
            VoiceButton(
              onResult: (text) {
                _controller.text = text;
                // 자동 검색 신호
                _searchKey.currentState?.triggerSearch();
              },
            ),
            const SizedBox(height: 12),

            // 🔹 검색 버튼
            SearchButton(
              key: _searchKey,
              controller: _controller,
              mapController: _mapController,
            ),
            const SizedBox(height: 16),

            // 🔹 지도
            Expanded(
              child: MapView(
                mapController: _mapController,
                center: _currentPosition ?? LatLng(37.5665, 126.9780),
                currentPosition: _currentPosition,
                markers: _markers,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
