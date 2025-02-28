import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerRequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 **Fetch Pending Requests**
  Future<List<Map<String, dynamic>>> getPendingRequests() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('requests')
          .where("status", isEqualTo: "pending")
          .get();

      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Attach document ID
        return data;
      }).toList();
    } catch (e) {
      print("🔥 Error fetching pending requests: $e");
      return [];
    }
  }

  /// 🔹 **Fetch Volunteer Name**
  Future<String?> getVolunteerName(String volunteerId) async {
    try {
      DocumentSnapshot volunteerDoc =
      await _firestore.collection('Volunteers').doc(volunteerId).get();
      if (volunteerDoc.exists && volunteerDoc.data() != null) {
        return volunteerDoc.get('name'); // Fetch name from Firestore
      }
    } catch (e) {
      print("🔥 Error fetching volunteer name: $e");
    }
    return null; // Return null if not found
  }

  /// 🔹 **Accept Request**
  Future<bool> acceptRequest({
    required String volunteerId,
    required String requestId,
    required String volunteerName,
  }) async {
    try {
      await _firestore.collection('requests').doc(requestId).update({
        "assignedVolunteerId": volunteerId,
        "assignedVolunteerName": volunteerName,
        "status": "assigned",
      });

      return true; // Successfully assigned
    } catch (e) {
      print("🔥 Error accepting request: $e");
      return false;
    }
  }
}
