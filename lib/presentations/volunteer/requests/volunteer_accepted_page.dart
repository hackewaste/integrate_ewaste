import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerStatusPage extends StatelessWidget {
  final String volunteerId;

  const VolunteerStatusPage({Key? key, required this.volunteerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Assigned Pickups")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where('assignedVolunteerId', isEqualTo: volunteerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No assigned pickups."));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              var request = doc.data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text("Pickup for User: ${request['userId']}"),
                  subtitle: Text("Status: ${request['status']}"),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
