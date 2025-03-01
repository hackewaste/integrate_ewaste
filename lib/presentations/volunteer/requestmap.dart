import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerRequestPage extends StatefulWidget {
  final String requestId; // Accept request ID from previous screen

  const VolunteerRequestPage({Key? key, required this.requestId}) : super(key: key);

  @override
  _VolunteerRequestPageState createState() => _VolunteerRequestPageState();
}

class _VolunteerRequestPageState extends State<VolunteerRequestPage> {
  LatLng? _userLocation;
  String? userName;
  String? address;
  String? itemName;
  int? quantity;
  int? creditPoints;

  @override
  void initState() {
    super.initState();
    _fetchRequestData();
  }

  Future<void> _fetchRequestData() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot requestSnapshot = await firestore
          .collection('requests')
          .doc(widget.requestId) // Use dynamic request ID
          .get();

      if (requestSnapshot.exists) {
        var data = requestSnapshot.data() as Map<String, dynamic>;

        setState(() {
          userName = data['name'];
          address = data['pickupAddress']['address'];
          itemName = data['name'];
          quantity = 1; 
          creditPoints = data['credits'];
          _userLocation = LatLng(
            data['pickupAddress']['latitude'],
            data['pickupAddress']['longitude'],
          );
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Volunteer Request")),
      body: _userLocation == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("User: ${userName ?? 'Loading...'}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Address: ${address ?? 'Loading...'}",
                      style: TextStyle(color: Colors.blueAccent)),
                  SizedBox(height: 12),
                  Text("E-Waste Item: ${itemName ?? 'Loading...'}",
                      style: TextStyle(fontSize: 16)),
                  Text("Quantity: ${quantity ?? 'Loading...'}"),
                  Text("Credit Points: ${creditPoints ?? 'Loading...'}"),
                  SizedBox(height: 20),
                  Expanded(
                    child: FlutterMap(
                      options: MapOptions(
                        center: _userLocation!,
                        zoom: 15.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 50.0,
                              height: 50.0,
                              point: _userLocation!,
                              child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
