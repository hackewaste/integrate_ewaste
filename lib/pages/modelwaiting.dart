import 'package:flutter/material.dart';
import 'dart:async';

class ProcessingScreen extends StatefulWidget {
  @override
  _ProcessingScreenState createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  void initState() {
    super.initState();

    // Simulating processing time before navigating
    Future.delayed(Duration(seconds: 60), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NextScreen()), // Replace with actual next screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Image
            Image.asset(
              'assets/logo.png', // Ensure this exists in your assets folder
              width: 250,
            ),
            const SizedBox(height: 20),

            // Processing Text
            const Text(
              "Hold while image is being processed...",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),

            // Loading Indicator
            const CircularProgressIndicator(
              color: Colors.blueGrey, // Adjust color as needed
            ),
          ],
        ),
      ),
    );
  }
}

// Replace this with the actual next screen
class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Next Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
