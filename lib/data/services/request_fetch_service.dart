import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/request_model.dart';

class RequestFetchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch request details including volunteer name & status
  Future<RequestModel?> getRequestDetails(String requestId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
      await _firestore.collection('requests').doc(requestId).get();

      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data()!;
        String? volunteerId = data['assignedVolunteerId'];

        String? volunteerName;
        if (volunteerId != null) {
          // Fetch Volunteer Name
          DocumentSnapshot<Map<String, dynamic>> volunteerDoc =
          await _firestore.collection('Volunteers').doc(volunteerId).get();
          if (volunteerDoc.exists && volunteerDoc.data() != null) {
            volunteerName = volunteerDoc.data()!['name'];
          }
        }

        data['assignedVolunteerName'] = volunteerName; // Add to request data

        return RequestModel.fromMap(doc.id, data);
      } else {
        return null;
      }
    } catch (e) {
      print("🔥 Error fetching request: $e");
      return null;
    }
  }
}
