import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/request_model.dart';

class RequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch request details by requestId
  Future<RequestModel?> getRequestDetails(String requestId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
      await _firestore.collection('requests').doc(requestId).get();

      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data()!; // Ensures data is not null
        print("✅ Request found: ${data.toString()}"); // Debugging Log
        return RequestModel.fromMap(doc.id, data);
      } else {
        print("❌ Request not found for ID: $requestId");
        return null;
      }
    } catch (e) {
      print("🔥 Error fetching request: $e");
      return null;
    }
  }
}
