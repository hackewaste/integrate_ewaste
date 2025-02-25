import 'package:flutter/material.dart';
import 'dart:async';

class GamificationScreen2 extends StatefulWidget {
  @override
  _GamificationScreenState createState() => _GamificationScreenState();
}

class _GamificationScreenState extends State<GamificationScreen2> {
  @override
  void initState() {
    super.initState();

    // Wait for 5 seconds, then navigate to the next screen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NextScreen()), // Change to your actual next screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Smart /n Categorization',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.grey[400],
                      height: 1.2,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/logo.png', // Ensure this exists
                        width: 250,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Section
          Container(
            padding: const EdgeInsets.all(32.0),
            decoration: const BoxDecoration(
              color: Color(0xFF7AB896), // Sage green color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: Column(
              children: [
                Text(
                'Users can scan and classify e-waste into hazardous, recyclable, and non-recyclable categories',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Dot indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == 1
                            ? const Color(0xFFE5A0B0) // Active dot
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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