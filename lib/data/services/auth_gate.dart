import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../presentations/volunteer/home/VolunteerHome.dart';
import '../../pages/login.dart';
import '../../presentations/user/home/userHomePage.dart';


class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          User? user = snapshot.data;
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('Users').doc(user!.uid).get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (userSnapshot.hasData && userSnapshot.data!.exists) {
                return UserHomePage();
              } else {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('Volunteers').doc(user.uid).get(),
                  builder: (context, volunteerSnapshot) {
                    if (volunteerSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (volunteerSnapshot.hasData && volunteerSnapshot.data!.exists) {
                      return VolunteerHomePage1();
                    } else {
                      return LoginPage();
                    }
                  },
                );
              }
            },
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}
