import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/location_summary_service.dart'; // Import location service

class RequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocationService _locationService = LocationService();

  /// Create a new request with user's location
  Future<String?> createRequest({
    required String userId,
    required List<Map<String, dynamic>> eWasteItems,
    required int totalCredits,
  }) async {
    try {
      // Fetch full location details
      Map<String, dynamic> locationData = await _locationService.getCurrentLocation();

      // Request Data
      Map<String, dynamic> requestData = {
        "userId": userId,
        "assignedVolunteerId": null,
        "eWasteItems": eWasteItems,
        "totalCredits": totalCredits,
        "status": "pending",
        "pickupAddress": locationData, // Stores latitude, longitude, and address
        "createdAt": FieldValue.serverTimestamp(),
      };

      DocumentReference requestRef = await _firestore.collection("requests").add(requestData);
      return requestRef.id;
    } catch (e) {
      print("Error creating request: $e");
      return null;
    }
  }
}
