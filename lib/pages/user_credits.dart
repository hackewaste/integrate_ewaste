import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCreditsPage extends StatefulWidget {
  const UserCreditsPage({super.key});

  @override
  State<UserCreditsPage> createState() => _UserCreditsPageState();
}

class _UserCreditsPageState extends State<UserCreditsPage> {
  int userCredits = 0;

  @override
  void initState() {
    super.initState();
    fetchUserCredits();
  }

  // Fetch credits from the new 'usercredits' collection
  Future<void> fetchUserCredits() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('usercredits').doc(user.uid).get();
      
      // If no document exists, initialize to 0
      if (doc.exists) {
        setState(() {
          userCredits = doc.data()?['credits'] ?? 0;
        });
      } else {
        // Create the document if it doesn't exist
        await FirebaseFirestore.instance.collection('usercredits').doc(user.uid).set({'credits': 0});
        setState(() {
          userCredits = 0;
        });
      }
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Credits'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'Your Credits: $userCredits',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
