import 'package:flutter/material.dart';

class UserAppbar extends StatelessWidget implements PreferredSizeWidget{
  const UserAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Homepage', style: TextStyle(color: Colors.black)),
      centerTitle: true,
      backgroundColor: Colors.blue[100],
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    );
  }
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
