import 'package:flutter/material.dart';

Widget HeaderSection() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.green[100],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Join us in creating a cleaner, greener future—donate your e-waste today and make a lasting impact on the environment!',
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Sell'),
        ),
      ],
    ),
  );
}