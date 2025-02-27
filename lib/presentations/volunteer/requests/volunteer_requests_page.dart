import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:ewaste/data/services/volunteer_service.dart';

class VolunteerRequestsPage extends StatefulWidget {
  @override
  _VolunteerRequestsPageState createState() => _VolunteerRequestsPageState();
}

class _VolunteerRequestsPageState extends State<VolunteerRequestsPage> {
  final VolunteerRequestService _volunteerService = VolunteerRequestService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Pickup Requests")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests') // Replace with your Firestore collection
            .where('status', isEqualTo: 'pending') // Filter by pending status
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No pending requests available."));
          }

          var requests = snapshot.data!.docs.map((doc) {
            return {
              'id': doc.id,
              'totalCredits': doc['totalCredits'],
              // Add other fields as needed
            };
          }).toList();

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text("Request ID: ${request['id']}"),
                  subtitle: Text("Credits: ${request['totalCredits']}"),
                  trailing: ElevatedButton(
                    onPressed: () => _acceptRequest(request['id']),
                    child: const Text("Accept"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _acceptRequest(String requestId) async {
    User? user = FirebaseAuth.instance.currentUser; // Get logged-in volunteer
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Not logged in! Please sign in first.")),
      );
      return;
    }

    String volunteerId = user.uid; // Firebase UID
    String? volunteerName = user.displayName; // Get name if set

    if (volunteerName == null) {
      // Fetch from Firestore if `displayName` is not available
      volunteerName = await _volunteerService.getVolunteerName(volunteerId);
    }

    bool success = await _volunteerService.acceptRequest(
      requestId: requestId,
      volunteerId: volunteerId,
      volunteerName: volunteerName ?? "Unknown",
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Request Accepted!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to accept request.")),
      );
    }
  }
}
