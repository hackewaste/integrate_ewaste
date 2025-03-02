import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ewaste/presentations/user/home/userHomePage.dart'; // Replace with your actual home screen
import 'package:ewaste/presentations/volunteer/home/VolunteerHome.dart'; // Fixed import
import 'package:ewaste/pages/register.dart';
import 'package:ewaste/pages/onboarding1.dart'; // Import onboarding screen

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      
      User? user = userCredential.user;
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
        if (!hasSeenOnboarding) {
          await prefs.setBool('hasSeenOnboarding', true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen(userId: user.uid)));
        } else {
          await _navigateAfterLogin(user.uid);
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed: ${e.message}";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      } else if (e.code == 'network-request-failed') {
        errorMessage = "Check your internet connection.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred."), backgroundColor: Colors.red),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _navigateAfterLogin(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    DocumentSnapshot volunteerDoc = await FirebaseFirestore.instance.collection('Volunteers').doc(userId).get();
    
    if (userDoc.exists) {
      await prefs.setString('role', 'user');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserHomePage()));
    } else if (volunteerDoc.exists) {
      await prefs.setString('role', 'volunteer');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VolunteerHomePage1())); // Fixed
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User role not found. Please sign up."), backgroundColor: Colors.orange),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text("Login"),
                  ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
