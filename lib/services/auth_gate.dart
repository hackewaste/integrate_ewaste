//import 'package:chatapp/services/auth/status.dart';
import 'package:ewaste/pages/UserHomePage.dart';
import 'package:ewaste/pages/VolunteerHomePage.dart';
import 'package:ewaste/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            // User is logged in, determine the route based on email domain
            final userEmail = snapshot.data?.email;
            if (userEmail != null && userEmail.endsWith('@volunteer.com')) {
              return VolunteerHomePage();
            } else {
              return UserHomePage();
            }
          } else {
            // User is not logged in, show the Login Page
            return Login();
          }
        });
  }
}
