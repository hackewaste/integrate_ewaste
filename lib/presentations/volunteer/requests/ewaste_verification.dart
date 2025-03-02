import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../data/models/request_model.dart';
 // Import the model

class WasteVerificationPage extends StatelessWidget {
  final String requestId;
  const WasteVerificationPage({Key? key, required this.requestId}) : super(key: key);

  Future<void> completeRequest(BuildContext context) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // 🔹 Fetch the request document and convert it to RequestModel
      DocumentSnapshot requestSnapshot =
      await firestore.collection("requests").doc(requestId).get();

      if (!requestSnapshot.exists) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Request not found!")));
        return;
      }

      // Convert Firestore data into RequestModel
      RequestModel request =
      RequestModel.fromMap(requestSnapshot.id, requestSnapshot.data() as Map<String, dynamic>);

      String userId = request.userId;
      int totalCredits = request.totalCredits;

      print("UserID: $userId, TotalCredits: $totalCredits"); // Debugging

      // 🔹 Fetch user's current credits
      DocumentReference userRef = firestore.collection("Users").doc(userId);
      DocumentSnapshot userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User not found!")));
        return;
      }

      int currentCredits = (userSnapshot["credits"] ?? 0) as int;
      int updatedCredits = currentCredits + totalCredits;

      print("Current Credits: $currentCredits, Updated Credits: $updatedCredits"); // Debugging

      // 🔹 Update user credits
      await userRef.update({"credits": updatedCredits});

      // 🔹 Update request status to "completed"
      await firestore.collection("requests").doc(requestId).update({"status": "pickedup"});

      // 🔹 Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("E-Waste Verified & Credits Updated!")),
      );

      Navigator.pop(context); // Close the page
    } catch (e) {
      print("❌ Error completing request: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error completing request!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("E-Waste Verification")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => completeRequest(context),
          child: Text("E-Waste Verified"),
        ),
      ),
    );
  }
}
