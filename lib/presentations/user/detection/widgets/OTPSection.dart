import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OTPSection extends StatelessWidget {
  final String requestId;

  const OTPSection({Key? key, required this.requestId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').doc(requestId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
          return const SizedBox(); // No card shown if request not found
        }

        var requestData = snapshot.data!.data() as Map<String, dynamic>?;
        if (requestData == null) {
          return const SizedBox();
        }

        String status = requestData['status']?.toString() ?? "pending";
        String? otp = requestData['otp']?.toString();

        if (status != "assigned" || otp == null) {
          return const SizedBox(); // Show nothing if status is not assigned or OTP is missing
        }

        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.black26,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.withOpacity(0.6), Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.lock, color: Colors.white, size: 30),
                const SizedBox(height: 10),
                const Text(
                  "Your OTP for Pickup",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  otp,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
