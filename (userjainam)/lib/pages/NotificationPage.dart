import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Stream to listen to notifications for the current user
  Stream<QuerySnapshot> _notificationsStream = FirebaseFirestore.instance
      .collection('notifications')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid) // Fetch notifications for the logged-in user
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _notificationsStream,
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

          // List of notifications
          List<DocumentSnapshot> notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var notification = notifications[index];
              return Dismissible(
                key: Key(notification.id), // Each Dismissible must have a unique key
                direction: DismissDirection.endToStart, // Left swipe direction
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
                  // Remove the notification from Firestore
                  FirebaseFirestore.instance
                      .collection('notifications')
                      .doc(notification.id)
                      .delete();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notification deleted')),
                  );
                },
                child: ListTile(
                  title: Text(notification['message']),
                  subtitle: Text(notification['timestamp']?.toDate().toString() ?? 'Unknown time'),
                  onTap: () {
                    // Mark the notification as read when tapped
                    notification.reference.update({'read': true});
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
