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
  List<Map<String, dynamic>> eWasteItems = [];
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
          eWasteItems = List<Map<String, dynamic>>.from(requestData['eWasteItems']);
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
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.blueAccent, size: 30),
                      SizedBox(width: 10),
                      Text(
                        userName ?? "Loading...",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Address Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: Colors.red, size: 30),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          address ?? "Loading...",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Item Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "E-Waste Items",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: eWasteItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.devices, color: Colors.green),
                            title: Text(eWasteItems[index]['name']),
                            subtitle: Text("Category: ${eWasteItems[index]['category']}"),
                          );
                        },
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoBadge(Icons.shopping_cart, "Quantity", quantity.toString()),
                          _infoBadge(Icons.credit_score, "Credits", creditPoints.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Map Section (Decent size)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 250, // Good visibility of the map
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
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Reached Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: ReachedButton(requestId: widget.requestId),
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  // Badge Widget for Quantity and Credits
  Widget _infoBadge(IconData icon, String title, String? value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 5),
          Text("$title: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? "0", style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
