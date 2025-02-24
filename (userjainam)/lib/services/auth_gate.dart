import 'package:ewaste/pages/UserHomePage.dart';
import 'package:ewaste/pages/VolunteerHomePage.dart';
import 'package:ewaste/pages/login.dart';
import 'package:ewaste/pages/dropImage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

 @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final userEmail = snapshot.data?.email ?? '';
          if (userEmail.endsWith('@volunteer.com')) {
            return const VolunteerHomePage();
          } else {
            return const UserHomepage();
          }
        }

        return const Login(); // Always fallback to Login if no user is authenticated
      },
    );
  }
}
