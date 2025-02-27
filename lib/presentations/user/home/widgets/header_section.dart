import 'package:ewaste/pages/dropImage.dart';
import 'package:ewaste/presentations/user/detection/detection_page.dart';
import 'package:ewaste/presentations/user/detection/widgets/detection_page.dart';
import 'package:flutter/material.dart';

Widget HeaderSection(context) {
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  DetectionPageF()),
            );
          },
          child: const Text('Sell'),
        ),
      ],
    ),
  );
}