import 'package:ewaste/pages/EarnPage.dart';
import 'package:ewaste/pages/info.dart';
import 'package:ewaste/pages/profilepages/UserAccountPage1.dart';
import 'package:flutter/material.dart';

import '../../pages/VolunteerHomePage.dart';

import 'home/userHomePage.dart';

class UserBottomNavigation extends StatefulWidget {
  const UserBottomNavigation({super.key});

  @override
  State<UserBottomNavigation> createState() => _UserBottomNavigationState();
}

class _UserBottomNavigationState extends State<UserBottomNavigation> {
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
              builder: (context) => const UserHomePage()),
        );
        break;
      case 1: // Explore
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const InfoPage()), // Replace with your ExplorePage widget
        );
        break;
      case 2: // Saved
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const EarnPage()), // Replace with your SavedPage widget
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserAccountPage(title: "")), // Replace with your SavedPage widget
        );
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
          label: 'Redeem',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
