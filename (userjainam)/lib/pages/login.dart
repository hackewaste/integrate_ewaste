import 'package:ewaste/pages/register.dart';
import 'package:ewaste/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:ewaste/services/auth_gate.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool _isLoggingIn = false;

  void login(BuildContext context) async {
    if (_isLoggingIn) return; // Prevent multiple login calls

    setState(() {
      _isLoggingIn = true; // Set logging-in flag
    });

    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        _emailController.text.trim(),
        _pwController.text.trim(),
      );

      // Navigate to appropriate page after login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthGate()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    } finally {
      setState(() {
        _isLoggingIn = false; // Reset logging-in flag
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hello User",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Enter your mail",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Enter your password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoggingIn
                  ? null
                  : () => login(context), // Disable button while logging in
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: _isLoggingIn
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Sign In", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
