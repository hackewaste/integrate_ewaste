import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Notify all volunteers about a new pickup request
  Future<void> notifyVolunteers(String requestId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> volunteers =
      await _firestore.collection('Volunteers').get();

      if (volunteers.docs.isEmpty) {
        print("⚠️ No volunteers found. Skipping notifications.");
        return;
      }

      for (var doc in volunteers.docs) {
        String volunteerId = doc.id;

        await _firestore.collection('notifications').add({
          "volunteerId": volunteerId,
          "requestId": requestId,
          "message": "New pickup request available!",
          "timestamp": FieldValue.serverTimestamp(),
          "status": "unread",
        });
      }
      print("✅ Notifications sent to all volunteers.");
    } catch (e) {
      print("🚨 Error sending notifications: $e");
    }
  }
}
