import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('requests')
            .where('userId', isEqualTo: _auth.currentUser!.uid) // Get requests for the logged-in user
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notifications available.'));
          }

          List<DocumentSnapshot> requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index];
              String requestId = request.id;
              String status = request['status'];
              String timestamp = request['createdAt']?.toDate().toString() ?? 'Unknown time';
              String message;

              if (status == 'Pending') {
                message = "Your request is pending.";
              } else if (status == 'Assigned') {
                String volunteerId = request['assignedVolunteerId'] ?? 'Unknown Volunteer';
                message = "Your request has been accepted by Volunteer ID: $volunteerId";
              } else {
                message = "Request status: $status";
              }

              return Dismissible(
                key: Key(requestId),
                direction: DismissDirection.endToStart, // Swipe to delete
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  // Remove notification when dismissed
                  _firestore.collection('requests').doc(requestId).delete();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notification deleted')),
                  );
                },
                child: ListTile(
                  title: Text(message),
                  subtitle: Text(timestamp),
                  onTap: () {
                    // Mark notification as read
                    request.reference.update({'read': true});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

