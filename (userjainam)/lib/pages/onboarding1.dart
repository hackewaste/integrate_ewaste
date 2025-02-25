import 'package:flutter/material.dart';
import 'onboarding2.dart'; // Import the next onboarding page

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
                        Positioned(
                          left: 0,
                          bottom: 100,
                          child: Image.asset(
                            'assets/leaves.png',
                            color: Colors.grey[200],
                            width: 100,
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/rewards.png',
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
          ClipPath(
            clipper: TopSlantClipper(),
            child: Container(
              padding: const EdgeInsets.all(32.0),
              color: const Color(0xFF7AB896),
              child: Column(
                children: [
                  Text(
                    'Automatically shares your real-time location with trusted contacts during critical times.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // 3 Dot Indicators (1st active)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == 0 ? const Color(0xFFE5A0B0) : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Arrow Button to Onboarding2
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GamificationScreen2()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                    ),
                    child: Icon(Icons.arrow_forward, size: 32),
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

class TopSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 100, 0);
    path.lineTo(size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
