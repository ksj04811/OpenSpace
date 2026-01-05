import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final LatLng center;
  final Set<Marker> markers;
  final void Function(GoogleMapController) onMapCreated;

  const MapView({
    super.key,
    required this.center,
    required this.markers,
    required this.onMapCreated,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.center,
        zoom: 15,
      ),
      markers: widget.markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: widget.onMapCreated,
    );
  }
}
