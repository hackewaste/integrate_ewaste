import 'package:ewaste/pages/login.dart';
import 'package:ewaste/presentations/user/home/userHomePage.dart';
import 'package:ewaste/pages/volunteerHomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User is logged in, fetch user role from Firestore
          final user = snapshot.data;
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('Users')
                .doc(user!.uid)
                .get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (userSnapshot.hasData && userSnapshot.data!.exists) {
                final role = userSnapshot.data!['role'];
                if (role == 'volunteer') {
                  return VolunteerHomePage();
                } else {
                  return UserHomePage();
                }
              } else {
                // If user document does not exist in 'Users' collection, check 'Volunteers' collection
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Volunteers')
                      .doc(user.uid)
                      .get(),
                  builder: (context, volunteerSnapshot) {
                    if (volunteerSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (volunteerSnapshot.hasData &&
                        volunteerSnapshot.data!.exists) {
                      final role = volunteerSnapshot.data!['role'];
                      if (role == 'volunteer') {
                        return VolunteerHomePage();
                      } else {
                        return UserHomePage();
                      }
                    } else {
                      // If user document does not exist in both collections, show an error or redirect to login
                      return Login();
                    }
                  },
                );
              }
            },
          );
        } else {
          // User is not logged in, show the Login Page
          return Login();
        }
      },
    );
  }
}
