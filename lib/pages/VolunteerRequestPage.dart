// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import '../data/models/location.dart';
// import '../data/models/user.dart';
// import '../data/models/ewaste_item.dart';
// import '../data/services/location_service.dart';

// class VolunteerRequestPage extends StatefulWidget {
//   @override
//   _VolunteerRequestPageState createState() => _VolunteerRequestPageState();
// }

// class _VolunteerRequestPageState extends State<VolunteerRequestPage> {
//   LatLng? _userLocation;
//   final LocationService _locationService = LocationService();

//   // Mock Data
//   final User user = User.mockUser();
//   final EwasteItem ewasteItem = EWasteItem.mockEwasteItem();
//   final LocationData userLocation = LocationData.mockLocation();

//   @override
//   void initState() {
//     super.initState();
//     _fetchLocation();
//   }

//   void _fetchLocation() async {
//     var position = await _locationService.getCurrentLocation();
//     if (position != null) {
//       setState(() {
//         _userLocation = position.getLatLng();
//       });
//     } else {
//       setState(() {
//         _userLocation = userLocation.getLatLng(); // Use mock location if real one is unavailable
//       });
//     }
//   }

//   void _acceptRequest() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Request Accepted!")),
//     );
//   }

//   void _declineRequest() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Request Declined!")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Volunteer Request")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("User: ${user.name}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text("Address: ${user.address}", style: TextStyle(color: Colors.blueAccent)),
//             SizedBox(height: 12),
//             Text("E-Waste Item: ${ewasteItem.itemName}", style: TextStyle(fontSize: 16)),
//             Text("Quantity: ${ewasteItem.quantity}"),
//             Text("Credit Points: ${ewasteItem.creditPoints}"),
//             SizedBox(height: 20),
//             Expanded(
//               child: _userLocation == null
//                   ? Center(child: CircularProgressIndicator())
//                   : FlutterMap(
//                       options: MapOptions(
//                         center: _userLocation!,
//                         zoom: 15.0,
//                       ),
//                       children: [
//                         TileLayer(
//                           urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                           subdomains: ['a', 'b', 'c'],
//                         ),
//                         MarkerLayer(
//                           markers: [
//                             Marker(
                              
//                               width: 50.0,
//                               height: 50.0,
//                               point: _userLocation!,
//                               //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//                               child: Icon(Icons.location_pin, color: Colors.red, size: 40),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: _acceptRequest,
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                   child: Text("Accept"),
//                 ),
//                 ElevatedButton(
//                   onPressed: _declineRequest,
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   child: Text("Decline"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
