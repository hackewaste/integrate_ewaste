import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  /// Check and request location permissions
  Future<bool> _handlePermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return false;
    }

    // Check current permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied.");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permission permanently denied.");
      return false;
    }

    return true;
  }

  /// Fetch current location with latitude, longitude, and address
  Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      // Ensure permissions are granted
      bool hasPermission = await _handlePermissions();
      if (!hasPermission) {
        return {
          "latitude": 0.0,
          "longitude": 0.0,
          "address": "Permission denied or location services disabled",
        };
      }

      // Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      // Fetch address using Nominatim API
      String url =
          "https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude";
      final response = await http.get(Uri.parse(url));

      String address = "Unknown Location";
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        address = data["display_name"] ?? "Unknown Location";
      }

      return {
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
      };
    } catch (e) {
      print("Error fetching location: $e");
      return {
        "latitude": 0.0,
        "longitude": 0.0,
        "address": "Error fetching location",
      };
    }
  }

  /// Fetch only the address (for UI display)
  Future<String?> getCurrentAddress() async {
    Map<String, dynamic> locationData = await getCurrentLocation();
    return locationData["address"];
  }
}