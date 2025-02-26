import 'package:flutter/material.dart';

import '../../../../pages/EarnPage.dart';

Widget ColabSection(context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple[100],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
            'Collab karo pls'),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> EarnPage())
            );
          },
          child: const Text('Join Now'),
        ),
      ],
    ),
  );
}