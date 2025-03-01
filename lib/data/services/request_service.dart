import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/notification_service.dart'; // Import notification service
import '../services/location_summary_service.dart'; // Import location service

class RequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocationService _locationService = LocationService();
  final NotificationService _notificationService = NotificationService(); // Notification service

  /// Create a new request with user's location and notify volunteers
  Future<String?> createRequest({
    required String userId,
    required List<Map<String, dynamic>> eWasteItems,
    required int totalCredits,
  }) async {
    try {
      // Fetch full location details
      Map<String, dynamic> locationData = await _locationService.getCurrentLocation();

      // Generate a random 4-digit OTP
      int otp = Random().nextInt(9000) + 1000; // Ensures OTP is between 1000-9999

      // Request Data
      Map<String, dynamic> requestData = {
        "userId": userId,
        "assignedVolunteerId": null,
        "eWasteItems": eWasteItems,
        "totalCredits": totalCredits,
        "status": "pending",
        "pickupAddress": locationData, // Stores latitude, longitude, and address
        "createdAt": FieldValue.serverTimestamp(),
        "otp": otp, // 🔹 Store OTP in Firestore
      };

      DocumentReference requestRef = await _firestore.collection("requests").add(requestData);
      String requestId = requestRef.id;

      // Send notification to volunteers
      await _notificationService.notifyVolunteers(requestId);

      return requestId;
    } catch (e) {
      print("❌ Error creating request: $e");
      return null;
    }
  }
}
