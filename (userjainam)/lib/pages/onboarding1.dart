import 'package:flutter/material.dart';

class GamificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Gamification & \nRewards -',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.grey[400],
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        // Decorative leaves
                        Positioned(
                          left: 0,
                          bottom: 100,
                          child: Image.asset(
                            'assets/leaves.png',
                            color: Colors.grey[200],
                            width: 100,
                          ),
                        ),
                        // Main illustration
                        Center(
                          child: Image.asset(
                            'assets/rewards.png', // Add your reward image
                            width: 250,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Slanted Green Section
          ClipPath(
            clipper: TopSlantClipper(),
            child: Container(
              padding: const EdgeInsets.all(32.0),
              color: const Color(0xFF7AB896), // Eco-friendly green color
              child: Column(
                children: [
                  Text(
                    'Automatically shares your real-time location with trusted contacts during critical times, ensuring they know where you are.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == 1
                              ? const Color(0xFFE5A0B0) // Pink color
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for Slanted Top Edge
class TopSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 100, 0); // Slant from left to 100px from right
    path.lineTo(size.width, 40); // Diagonal cut
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(0, size.height); // Bottom-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}