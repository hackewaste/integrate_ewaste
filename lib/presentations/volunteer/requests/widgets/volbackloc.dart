import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';  // Add Firestore import

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  LatLng? currentLocation;
  final LatLng destinationLocation = LatLng(19.0760, 72.8777); // Mumbai
  List<LatLng> routePoints = [];
  
  // Assume requestId is passed to the widget
  final String requestId = "sample_request_id"; // Replace with actual requestId
  
  @override
  void initState() {
    super.initState();
    _locateUser();
  }

  Future<void> _locateUser() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enable location services')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    if (currentLocation == null) return;

    final url = Uri.parse(
        "https://router.project-osrm.org/route/v1/driving/${currentLocation!.longitude},${currentLocation!.latitude};${destinationLocation.longitude},${destinationLocation.latitude}?overview=full&geometries=geojson");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final coordinates = data['routes'][0]['geometry']['coordinates'] as List;
        final points = coordinates.map((point) => LatLng(point[1], point[0])).toList();

        setState(() {
          routePoints = points;
        });
      }
    } catch (e) {
      print("Error fetching route: $e");
    }
  }

  // Function to update Firestore and mark the request as "completed"
  Future<void> endRequest() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot requestSnapshot =
          await firestore.collection("requests").doc(requestId).get();

      if (!requestSnapshot.exists) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Request not found!")));
        return;
      }

      // Update the request status to "completed"
      await firestore.collection("requests").doc(requestId).update({"status": "completed"});

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request marked as completed")));

      // Optional: You can navigate or perform any other actions after completion

    } catch (e) {
      print("❌ Error completing request: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error completing request!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('E-Waste Delivery Route')),
      body: Stack(
        children: [
          DisposalMap(currentLocation: currentLocation, routePoints: routePoints),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 5),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Route to Mumbai',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'From: ${currentLocation?.latitude ?? 'Loading...'}, ${currentLocation?.longitude ?? 'Loading...'}\n'
                    'To: ${destinationLocation.latitude}, ${destinationLocation.longitude}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: endRequest, // Call endRequest to update status
                        child: const Text('End'), // Change text to 'End'
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisposalMap extends StatelessWidget {
  final LatLng? currentLocation;
  final List<LatLng> routePoints;

  const DisposalMap({this.currentLocation, required this.routePoints});

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
                point: currentLocation!,
                child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 50.0),
              ),
            Marker(
              point: LatLng(19.0760, 72.8777),
              child: const Icon(Icons.location_on, color: Colors.red, size: 50.0),
            ),
          ],
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: routePoints,
              color: Colors.blue,
              strokeWidth: 5.0,
            ),
          ],
        ),
      ],
    );
  }
}
