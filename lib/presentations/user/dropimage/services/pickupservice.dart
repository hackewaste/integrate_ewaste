import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewaste/pages/pickupfinal.dart';
import 'package:flutter/material.dart';

class PickupService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> requestPickup(BuildContext context, List<Map<String, dynamic>> detectionResults, int Function(Map<String, int>) calculateTotalCredits) async {
    if (detectionResults.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No results to request pickup.')),
      );
      return;
    }

    try {
      final requestId = _firestore.collection('pickupRequests').doc().id;

      await _firestore.collection('pickupRequests').doc(requestId).set({
        'status': 'pending',
        'created_at': FieldValue.serverTimestamp(),
      });

      Map<String, int> detectedItems = {};

      for (var result in detectionResults) {
        for (var detection in result['detections']) {
          String category = detection['class_name'];
          detectedItems[category] = (detectedItems[category] ?? 0) + 1;
        }
      }

      int totalCredits = calculateTotalCredits(detectedItems);

      for (var result in detectionResults) {
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

      await _firestore.collection('pickupRequests').doc(requestId).set({
        'totalCredits': totalCredits,
      }, SetOptions(merge: true));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PickupRequestPage(requestId: requestId),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to store results: $e')),
      );
    }
  }
}
