import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/location.dart';

class LocationService {
  Future<LocationData?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return null;
    }

    Position position = await Geolocator.getCurrentPosition();
    return LocationData(latitude: position.latitude, longitude: position.longitude);
  }
}
