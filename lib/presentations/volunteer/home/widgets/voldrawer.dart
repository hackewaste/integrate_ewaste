import 'package:ewaste/pages/profilepages/UserAccountPage1.dart';
import 'package:flutter/material.dart';


class VolDrawer extends StatelessWidget {
  const VolDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Text(
              'Volunteer Menu',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserAccountPage(title: 'volunteer profile page',)),
              );
            },
          ),
        ],
      ),
    );
  }
}
