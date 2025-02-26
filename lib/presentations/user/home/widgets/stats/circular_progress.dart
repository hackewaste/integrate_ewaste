
import 'dart:ui';

import 'package:flutter/material.dart';

Widget buildDailyActivity() {
  return Row(
    children: [
      SizedBox(
        width: 120,
        height: 120,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: 0.75,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '20',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF324F5E),
                    ),
                  ),
                  Text(
                    'June',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF324F5E),
              ),
            ),
            const SizedBox(height: 10),
            _buildActivityLegendItem('Walk', Colors.amber),
            _buildActivityLegendItem('Rest', Colors.red),
            _buildActivityLegendItem('Sit', Colors.green),
          ],
        ),
      ),
    ],
  );
}

Widget _buildActivityLegendItem(String label, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
