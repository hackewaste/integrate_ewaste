import 'package:flutter/material.dart';
import 'package:ewaste/presentations/user/DYK/recycling_steps.dart';



class RecyclingProcessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecyclingStepsPage()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Keeps it compact
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.recycling, color: Colors.teal, size: 30),
            SizedBox(width: 10),
            Text(
              "DID YOU KNOW?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
          ],
        ),
      ),
    );
  }
}