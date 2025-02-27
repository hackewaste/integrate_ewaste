// import 'package:flutter/material.dart';
// import 'services/location_summary_service.dart';

// class LocationWidget extends StatefulWidget {
//   const LocationWidget({super.key});

//   @override
//   State<LocationWidget> createState() => _LocationWidgetState();
// }

// class _LocationWidgetState extends State<LocationWidget> {
//   String? _currentLocation;
//   final LocationService _locationService = LocationService();

//   @override
//   void initState() {
//     super.initState();
//     _fetchLocation();
//   }

//   Future<void> _fetchLocation() async {
//     var location = await _locationService.getCurrentLocation();
//     if (location != null) {
//       setState(() {
//         _currentLocation = "${location.latitude}, ${location.longitude}";
//       });
//     } else {
//       setState(() {
//         _currentLocation = "Location not available";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: _currentLocation ?? "Fetching location...",
//         prefixIcon: const Icon(Icons.location_on, color: Colors.red),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//       ),
//       readOnly: true,
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'location_summary_service.dart';

// class LocationWidget extends StatefulWidget {
//   const LocationWidget({super.key});

//   @override
//   State<LocationWidget> createState() => _LocationWidgetState();
// }

// class _LocationWidgetState extends State<LocationWidget> {
//   String? _currentAddress;
//   final LocationService _locationService = LocationService();

//   @override
//   void initState() {
//     super.initState();
//     _fetchAddress();
//   }

//   Future<void> _fetchAddress() async {
//     var address = await _locationService.getCurrentAddress();
//     setState(() {
//       _currentAddress = address;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: _currentAddress ?? "Fetching address...",
//         prefixIcon: const Icon(Icons.location_on, color: Colors.red),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//       ),
//       readOnly: true,
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'services/location_summary_service.dart';

// class LocationWidget extends StatefulWidget {
//   const LocationWidget({super.key});

//   @override
//   State<LocationWidget> createState() => _LocationWidgetState();
// }

// class _LocationWidgetState extends State<LocationWidget> {
//   String? _currentAddress;
//   final LocationService _locationService = LocationService();

//   @override
//   void initState() {
//     super.initState();
//     _fetchAddress();
//   }

//   Future<void> _fetchAddress() async {
//     var address = await _locationService.getCurrentAddress();
//     setState(() {
//       _currentAddress = address;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal, // Enable scrolling
//         child: Row(
//           children: [
//             const Icon(Icons.location_on, color: Colors.red),
//             const SizedBox(width: 8),
//             Text(
//               _currentAddress ?? "Fetching address...",
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../data/services/location_summary_service.dart';

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

    var address = await _locationService.getCurrentAddress();

    setState(() {
      _currentAddress = address;
      _isLoading = false;
    });
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
