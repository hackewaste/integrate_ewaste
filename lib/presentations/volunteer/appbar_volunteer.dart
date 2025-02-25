import 'package:flutter/material.dart';

class AppbarVolunteer extends StatelessWidget implements PreferredSizeWidget{
  const AppbarVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Volunteer Dashboard',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {

          },
        ),
      ],
    );
  }
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
