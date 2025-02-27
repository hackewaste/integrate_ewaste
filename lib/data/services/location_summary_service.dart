import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  /// Fetch current location with latitude, longitude, and address
  Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

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

  /// Fetch only the address (for UI)
  Future<String?> getCurrentAddress() async {
    Map<String, dynamic> locationData = await getCurrentLocation();
    return locationData["address"];
  }
}
