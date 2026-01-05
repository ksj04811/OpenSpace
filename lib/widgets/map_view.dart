import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  final MapController mapController;
  final LatLng center;
  final LatLng? currentPosition; // 현위치 좌표
  final List<Marker> markers; // 기존 마커 리스트
  final double zoom;

  const MapView({
    super.key,
    required this.mapController,
    required this.center,
    this.currentPosition,
    this.markers = const [],
    this.zoom = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    // 현위치 마커 생성
    final List<Marker> allMarkers = List.from(markers);
    if (currentPosition != null) {
      allMarkers.add(
        Marker(
          point: currentPosition!,
          width: 40,
          height: 40,
          child: const Icon(
            Icons.my_location,
            color: Colors.blue,
            size: 40,
          ),
        ),
      );
    }

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: center,
        zoom: zoom,
        interactiveFlags: InteractiveFlag.all,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.yourapp',
        ),
        if (allMarkers.isNotEmpty) MarkerLayer(markers: allMarkers),
      ],
    );
  }
}