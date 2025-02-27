import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> storeDetectionResults(List<Map<String, dynamic>> results, int totalCredits) async {
    final requestId = _firestore.collection('pickupRequests').doc().id;

    await _firestore.collection('pickupRequests').doc(requestId).set({
      'status': 'pending',
      'totalCredits': totalCredits,
      'created_at': FieldValue.serverTimestamp(),
    });

    for (var result in results) {
      await _firestore
          .collection('pickupRequests')
          .doc(requestId)
          .collection('results')
          .add({
        'fileName': result['fileName'],
        'detections': result['detections'],
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    return requestId;
  }
}