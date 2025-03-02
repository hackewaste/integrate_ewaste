import 'package:ewaste/presentations/volunteer/requests/widgets/reached_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestMap extends StatefulWidget {
  final String requestId;

  const RequestMap({Key? key, required this.requestId}) : super(key: key);

  @override
  _RequestMapState createState() => _RequestMapState();
}

class _RequestMapState extends State<RequestMap> {
  LatLng? _userLocation;
  LatLng? _volunteerLocation;
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
          .doc(widget.requestId)
          .get();

      if (requestSnapshot.exists) {
        var requestData = requestSnapshot.data() as Map<String, dynamic>;
        String userId = requestData['userId'];
        String volunteerId = requestData['assignedVolunteerId'];

        DocumentSnapshot userSnapshot = await firestore
            .collection('Users')
            .doc(userId)
            .get();

        String userNameFetched = userSnapshot.exists
            ? userSnapshot['name']
            : 'Unknown';

        DocumentSnapshot volunteerSnapshot = await firestore
            .collection('Volunteers')
            .doc(volunteerId)
            .get();

        if (volunteerSnapshot.exists) {
          var volunteerData = volunteerSnapshot.data() as Map<String, dynamic>;
          _volunteerLocation = LatLng(
            volunteerData['location']['latitude'],
            volunteerData['location']['longitude'],
          );
        }

        setState(() {
          userName = userNameFetched;
          address = requestData['pickupAddress']['address'];
          itemName = requestData['eWasteItems']
              .map((item) => item['name'])
              .join(', ');
          quantity = requestData['eWasteItems'].length;
          creditPoints = requestData['totalCredits'];
          _userLocation = LatLng(
            requestData['pickupAddress']['latitude'],
            requestData['pickupAddress']['longitude'],
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
                            if (_volunteerLocation != null)
                              Marker(
                                width: 50.0,
                                height: 50.0,
                                point: _volunteerLocation!,
                                child: Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
                              ),
                          ],
                        ),
                      ],//9hm6
                    ),
                  ),
                  SizedBox(height: 20),
                  ReachedButton(requestId: widget.requestId),
                ],
              ),
            ),
    );
  }
}
