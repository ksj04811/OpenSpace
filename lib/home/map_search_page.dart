import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_tutorial/widgets/map_view.dart';
import 'package:flutter_tutorial/widgets/voice_button.dart';
import 'package:flutter_tutorial/widgets/search_button.dart';
import 'package:flutter_tutorial/widgets/search_bar.dart';
import 'package:flutter_tutorial/widgets/top_bar.dart';
import 'package:flutter_tutorial/widgets/bottom_bar.dart';

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

  // 🔹 BottomBar 상태
  int _currentIndex = 0;

  // 🔹 음성 인식 상태 (다음 단계용)
  bool _isListening = false;

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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Stack(
        children: [
          // 🗺️ 지도
          MapView(
            mapController: _mapController,
            center: _currentPosition ?? const LatLng(37.5665, 126.9780),
            currentPosition: _currentPosition,
            markers: _markers,
          ),

          // 🔍 검색 UI Row
          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 8,
            child: Row(
              children: [
                // 검색창
                Expanded(
                  flex: 7,
                  child: CustomSearchBar(
                    controller: _controller,
                    isListening: _isListening,
                  ),
                ),
                const SizedBox(width: 8),

                // 음성 버튼
                Expanded(
                  flex: 1,
                  child: VoiceButton(
                    onResult: (text) {
                      _controller.text = text;
                      _searchKey.currentState?.triggerSearch();
                    },
                    onListeningChanged: (listening) {
                      setState(() {
                        _isListening = listening;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),

                // 검색 버튼
                Expanded(
                  flex: 1,
                  child: SearchButton(
                    key: _searchKey,
                    controller: _controller,
                    mapController: _mapController,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ⬇️ 하단바
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
