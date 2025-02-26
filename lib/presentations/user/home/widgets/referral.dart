import 'package:flutter/material.dart';

import '../../../../pages/EarnPage.dart';

Widget InviteSection(context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blue[100],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
            'Earn tokens for each friend invited who makes a donation'),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> EarnPage())
            );
          },
          child: const Text('Invite Now'),
        ),
      ],
    ),
  );
}