
import 'package:ewaste/presentations/user/detection/detection_page.dart';
import 'package:ewaste/presentations/user/detection/widgets/detection_page.dart';
import 'package:flutter/material.dart';
import 'package:ewaste/pages/dropimageai(working).dart';

Widget headerSection(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.teal[100],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Turn your e-waste into impact! Sell or donate today and contribute to a cleaner planet.",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
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
