import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class DisposalMap extends StatelessWidget {
  final LatLng? currentLocation;

  DisposalMap({this.currentLocation});

  final List<LatLng> disposalLocations = [
    LatLng(19.0760, 72.8777), // Mumbai
    LatLng(19.2183, 72.9781), // Andheri
    LatLng(19.0473, 72.8777), // Navi Mumbai
    LatLng(18.9543, 72.8200), // Colaba
    LatLng(19.0330, 73.0297), // Vashi
    LatLng(18.9990, 72.8410), // Worli
    LatLng(19.1136, 72.8697), // Goregaon
  ];

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: currentLocation ?? LatLng(19.0760, 72.8777),
        initialZoom: 12.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
            markers: [
              if (currentLocation != null)
                Marker(
                  width: 50.0,
                  height: 50.0,
                  point: currentLocation!,
                  child: Icon(
                    Icons.person_pin_circle,
                    color: Colors.blue.shade700,
                    size: 50.0,
                  ),
                ),
              ...disposalLocations.map((location) => _buildMarker(location)),
            ],
          ),
      ],
    );
  }

  Marker _buildMarker(LatLng location) {
    return Marker(
      width: 50.0,
      height: 50.0,
      point: location,
      child: Icon(
        Icons.location_on,
        color: Colors.red.shade700,
        size: 50.0,
      ),
    );
  }
}
