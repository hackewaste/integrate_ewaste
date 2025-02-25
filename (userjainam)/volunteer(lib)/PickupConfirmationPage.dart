import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PickupConfirmationPage extends StatelessWidget {
  final String requestId; // Unique request ID
  final String userId; // User's ID
  final int credits; 

  PickupConfirmationPage({
    required this.requestId,
    required this.userId,
    required this.credits, 
  });

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> confirmPickup(BuildContext context) async {
    try {
      // Step 1: Get the user's document
      DocumentReference userRef = _firestore.collection('users').doc(userId);
      DocumentSnapshot userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        throw Exception("User does not exist!");
      }

      // Step 2: Find the correct pickup entry by matching requestId
      List<dynamic> pickups = userSnapshot['pickups'] ?? [];
      Map<String, dynamic>? matchedPickup;

      for (var pickup in pickups) {
        if (pickup['requestId'] == requestId) {
          matchedPickup = pickup;
          break;
        }
      }

      if (matchedPickup == null) {
        throw Exception("Pickup not found for requestId: $requestId");
      }

      int earnedCredits = matchedPickup['credits'] ?? 0;

      // Step 3: Update the request status to 'completed'
      await _firestore.collection('usertemporary').doc(requestId).update({
        'status': 'completed',
      });

      // Step 4: Update user's credits in 'usercredits' collection
      DocumentReference userCreditsRef =
          _firestore.collection('usercredits').doc(userId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot creditsSnapshot = await transaction.get(userCreditsRef);

        int currentCredits = 0;
        if (creditsSnapshot.exists) {
          currentCredits = (creditsSnapshot['credits'] ?? 0) as int;
        }

        int updatedCredits = currentCredits + earnedCredits;
        transaction.set(userCreditsRef, {'credits': updatedCredits});
      });

      // Step 5: Notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pickup confirmed, credits updated!")),
      );

      // Step 6: Navigate back
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Pickup"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Confirm that the e-waste pickup is completed.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => confirmPickup(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text("Pickup Completed"),
            ),
          ],
        ),
      ),
    );
  }
}
