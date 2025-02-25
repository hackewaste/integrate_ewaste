import 'package:flutter/material.dart';

import '../../pages/VolunteerHomePage.dart';

class VolunteerBottomNavigation extends StatefulWidget {
  const VolunteerBottomNavigation({super.key});

  @override
  State<VolunteerBottomNavigation> createState() => _VolunteerBottomNavigationState();
}

class _VolunteerBottomNavigationState extends State<VolunteerBottomNavigation> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });


    // Navigation logic for each index
    switch (index) {
      case 0: // Home
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const VolunteerHomePage()),
        );
        break;
      case 1: // Explore
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const VolunteerHomePage()), // Replace with your ExplorePage widget
        );
        break;
      case 2: // Saved
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const VolunteerHomePage()), // Replace with your SavedPage widget
        );
        break;
      case 3:
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
