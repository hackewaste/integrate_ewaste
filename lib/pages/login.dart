import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/services/auth_service.dart';
import '../presentations/user/home/userHomePage.dart';
import '../pages/volunteerHomePage.dart';
import '../presentations/volunteer/home/VolunteerHome.dart';
import 'register.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      UserCredential user = await authService.signInWithEmailPassword(
        _emailController.text.trim(),
        _pwController.text.trim(),
      );

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("Users").doc(user.user!.uid).get();
      DocumentSnapshot volunteerDoc = await FirebaseFirestore.instance.collection("Volunteers").doc(user.user!.uid).get();

      if (userDoc.exists) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserHomePage()));
      } else if (volunteerDoc.exists) {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VolunteerHomePage1()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User role not found!")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Enter your email", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Enter your password", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text("Sign In"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
