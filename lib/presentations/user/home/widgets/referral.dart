import 'package:flutter/material.dart';

import '../../../../pages/EarnPage.dart';

Widget InviteSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue[100]!, Colors.blue[50]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 168, 203, 232).withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      border: Border.all(
        color: const Color.fromARGB(255, 208, 234, 255)!,
        width: 1.5,
      ),
    ),
    child: Row(
      children: [
        // Left side - Coin decoration
        Stack(
          alignment: Alignment.center,
          children: [
            // Larger coin in back
            _buildCoin(
              size: 60,
              color: Colors.amber[600]!,
              offsetX: -5,
              offsetY: 5,
            ),
            // Medium coin in middle
            _buildCoin(
              size: 50,
              color: Colors.amber[500]!,
              offsetX: 10,
              offsetY: -10,
            ),
            // Small coin in front
            _buildCoin(
              size: 40,
              color: Colors.amber[400]!,
              offsetX: 20,
              offsetY: 15,
            ),
          ],
        ),
        
        const SizedBox(width: 16.0),
        
        // Right side - Text and button
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Earn Credits!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Invite friends who make a donation and get rewarded with bonus tokens',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EarnPage())
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 162, 255),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                icon: const Icon(Icons.share, size: 18),
                label: const Text('Start Now'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCoin({
  required double size,
  required Color color,
  required double offsetX,
  required double offsetY,
}) {
  return Transform.translate(
    offset: Offset(offsetX, offsetY),
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.amber[800]!,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '₹',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.5,
          ),
        ),
      ),
    ),
  );
}