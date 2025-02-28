import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../data/services/location_summary_service.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String? _currentAddress;
  final LocationService _locationService = LocationService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    setState(() {
      _isLoading = true;
    });

    var locationData = await _locationService.getCurrentLocation();
    String? address = locationData["address"];
    double latitude = locationData["latitude"];
    double longitude = locationData["longitude"];

    setState(() {
      _currentAddress = address;
      _isLoading = false;
    });

    // Save location to Firebase
    _updateLocationInFirestore(latitude, longitude, address);
  }

  Future<void> _updateLocationInFirestore(
      double latitude, double longitude, String? address) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection("Volunteers")
            .doc(user.uid)
            .update({
          "location": {
            "latitude": latitude,
            "longitude": longitude,
          },
          "address": address ?? "Unknown Location",
        });
      } catch (e) {
        print("Error updating location: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Location Icon
            const Icon(Icons.location_on, color: Colors.red, size: 28),

            const SizedBox(width: 8),

            // Scrollable Address Text
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  _currentAddress ?? "Fetching address...",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            // Refresh Button
            IconButton(
              icon: _isLoading
                  ? const CircularProgressIndicator(strokeWidth: 2)
                  : const Icon(Icons.refresh, color: Colors.blue),
              onPressed: _isLoading ? null : _fetchAddress, // Disable if loading
            ),
          ],
        ),
      ),
    );
  }
}
