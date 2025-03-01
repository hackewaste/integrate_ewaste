import 'package:flutter/material.dart';
import 'package:ewaste/pages/dropimageai(working).dart';

Widget headerSection(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.green[100],
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
            color: Colors.green[900],
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          width: double.infinity, // Makes the button full-width
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DropImagePage()),
              );
            },
            child: const Text(
              "Sell Now",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ],
    ),
  );
}
