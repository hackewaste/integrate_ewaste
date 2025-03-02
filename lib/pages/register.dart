import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/services/auth_service.dart';
import '../presentations/user/home/userHomePage.dart';
import '../pages/volunteerHomePage.dart';
import '../presentations/volunteer/home/VolunteerHome.dart';
import 'login.dart';
import 'package:ewaste/pages/onboarding1.dart';
import 'package:ewaste/pages/login.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'User'; // Default role

  final AuthService _authService = AuthService();

  void registerUser() async {
    try {
      UserCredential userCredential = await _authService.signUpWithEmailPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        role: _selectedRole,
      );

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardingScreen(userId: userCredential.user!.uid)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Register")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildTextField(_nameController, "Full Name"),
            SizedBox(height: 12),
            _buildTextField(_emailController, "Email"),
            SizedBox(height: 12),
            _buildTextField(_phoneController, "Phone"),
            SizedBox(height: 12),
            _buildTextField(_passwordController, "Password", obscureText: true),
            SizedBox(height: 12),

            // Role selection
            DropdownButtonFormField<String>(
              value: _selectedRole,
              items: ["User", "Volunteer"].map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Select Role"),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: registerUser,
              child: Text("Sign Up"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("Already have an account? Sign In"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
