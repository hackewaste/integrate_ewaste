import 'package:flutter/material.dart';

import '../../../../pages/EarnPage.dart';

import 'package:flutter/material.dart';
import 'package:ewaste/presentations/user/collab/collabator.dart';

Widget ColabSection(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple[50]!, const Color.fromARGB(255, 255, 212, 221)!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 247, 205, 157).withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
      border: Border.all(
        color: Colors.deepPurple[200]!,
        width: 1.0,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side - Illustration
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 255, 239, 180).withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.handshake_outlined,
              size: 50,
              color: const Color.fromARGB(255, 251, 144, 114),
            ),
          ),
        ),
        
        const SizedBox(width: 20.0),
        
        // Right side - Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Business Collaboration',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 35, 8, 3),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Partner with like-minded businesses to expand your reach and create mutual growth opportunities.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  RecyclerCollaborationPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Join Partnership',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    ),
    const SizedBox(width: 8),
    Expanded(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: const Color.fromARGB(255, 255, 251, 197)!),
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          'Learn More',
          style: TextStyle(
            color: Colors.deepPurple[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  ],
),

            ],
          ),
        ),
      ],
    ),
  );
}