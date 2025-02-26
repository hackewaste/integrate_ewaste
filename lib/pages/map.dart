import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int _currentIndex = 0;
  final LatLng currentLocation = LatLng(19.1864, 72.9702); // Ensure this is properly defined
  LatLng? destinationLocation; // Destination from Firestore
  List<LatLng> routePoints = []; // Route polyline points
  @override
  void initState() {
    super.initState();
    _fetchLatestRequestAndDestination();
  }

  /// Fetches the latest request and extracts its destination coordinates
  Future<void> _fetchLatestRequestAndDestination() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('requests')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot latestRequest = querySnapshot.docs.first;
        String requestId = latestRequest.id;

        Map<String, dynamic>? data = latestRequest.data() as Map<String, dynamic>?;

        print("Raw Firestore Data: $data");  // Debugging

        if (data != null && data.containsKey('dAddGeopoint')) {
          GeoPoint geoPoint = data['dAddGeopoint'];

          if (mounted) {
            setState(() {
              destinationLocation = LatLng(geoPoint.latitude, geoPoint.longitude);
            });
          }

          print("Fetched Request ID: $requestId");
          print("Destination Location: ${geoPoint.latitude}, ${geoPoint.longitude}");

          _fetchRoute(); // Call only if destination is valid
        } else {
          print("Error: dAddGeopoint not found in latest request.");
        }
      } else {
        print("Error: No requests found.");
      }
    } catch (e) {
      print("Error fetching latest request and destination: $e");
    }
  }


  /// Fetches route from currentLocation to destinationLocation using OSRM API
  Future<void> _fetchRoute() async {
    if (destinationLocation == null) {
      print("Destination is null. Cannot fetch route.");
      return;
    }

    final url = Uri.parse(
        "https://router.project-osrm.org/route/v1/driving/${currentLocation.longitude},${currentLocation.latitude};${destinationLocation!.longitude},${destinationLocation!.latitude}?overview=full&geometries=geojson");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final coordinates = data['routes'][0]['geometry']['coordinates'] as List;
        final points = coordinates.map((point) => LatLng(point[1], point[0])).toList();

        setState(() {
          routePoints = points;
        });

        print("Route fetched successfully with ${points.length} points.");
      } else {
        print("Failed to fetch route: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching route: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Delivery Route'),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onVerticalDragStart: (details) {}, // Suppress vertical drag gestures
            child: FlutterMap(
              options: MapOptions(
                center: currentLocation,
                zoom: 15.0,
                minZoom: 3.0,
                maxZoom: 18.0,
                interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: currentLocation,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                    if (destinationLocation != null)
                      Marker(
                        point: destinationLocation!,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                  ],
                ),
                if (routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routePoints,
                        color: Colors.deepPurple,
                        strokeWidth: 4.0,
                      ),
                    ],
                  ),
              ],
            ),
          ),
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
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Delivery Route',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'From: ${currentLocation.latitude}, ${currentLocation.longitude}\n'
                        'To: ${destinationLocation?.latitude ?? "Loading..."}, ${destinationLocation?.longitude ?? "Loading..."}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.deepPurple),
                        ),
                        onPressed: () {
                          // Cancel action
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: destinationLocation == null
                            ? null
                            : () {
                          // Confirm action
                        },
                        child: const Text('Start'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
