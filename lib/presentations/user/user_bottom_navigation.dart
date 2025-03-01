import 'package:flutter/material.dart';
import 'package:ewaste/pages/EarnPage.dart';
import 'package:ewaste/pages/info.dart';
import 'package:ewaste/pages/profilepages/UserAccountPage1.dart';
import 'package:ewaste/presentations/user/home/userHomePage.dart';

class UserBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const UserBottomNavigation({Key? key, required this.currentIndex}) : super(key: key);

  void _onTabSelected(BuildContext context, int index) {
    if (index == currentIndex) return; // Prevent reloading the same page

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, _createRoute(const UserHomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, _createRoute(const InfoPage()));
        break;
      case 2:
        Navigator.pushReplacement(context, _createRoute(const EarnPage()));
        break;
      case 3:
        Navigator.pushReplacement(context, _createRoute(UserAccountPage(title: "")));
        break;
    }
  }

  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTabSelected(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Redeem'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
