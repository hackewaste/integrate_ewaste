import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';

class LocationData {
  final double latitude;
  final double longitude;

  LocationData({required this.latitude, required this.longitude});

  static LocationData mockLocation() {
    return LocationData(latitude: 40.7128, longitude: -74.0060); // Mock location (New York)
  }

  LatLng getLatLng() {
    return LatLng(latitude, longitude);
  }
}
