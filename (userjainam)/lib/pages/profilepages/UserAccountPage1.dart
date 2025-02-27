
import 'package:flutter/material.dart';
import 'package:ewaste/pages/profilepages/UserAccPage2.dart';
import 'package:ewaste/pages/volunteerpages/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:ewaste/pages/userHomePage.dart';
import 'package:ewaste/services/auth_service.dart';
import 'package:ewaste/pages/login.dart';
import 'package:ewaste/pages/user_credits.dart';
import 'package:ewaste/pages/profilepages/activitylog.dart';
import 'package:ewaste/pages/profilepages/helpsupport.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserAccountPage(title:' User Profile'),
    );
  }
}

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key, required this.title});

  final String title;

  @override
  State<UserAccountPage> createState() => _UserAccountPage();
}

class _UserAccountPage extends State<UserAccountPage> {

  int _currentIndex = 3;

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
              builder: (context) => UserHomepage()),
        );
        break;
      case 1: // Explore
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ExplorePage()), // Replace with your ExplorePage widget
        );
        break;
      case 2: // Saved
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SavedPage()), // Replace with your SavedPage widget
        );
        break;
      case 3: // Profile
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  const UserAccountPage(title:'User Profile')), // Replace with your ProfilePage widget
        );
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //  ),
      
      ),
      body: 
      ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Section
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: const AssetImage('assets/volunteer.png'),
                  onBackgroundImageError: (_, __) {
                    print("Error loading profile picture.");
                  },
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'John Doe',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const Text('john.doe@example.com', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          const SizedBox(height: 24.0),

_buildOptionTile(
            context,
            icon: Icons.credit_card,
            title: 'User Credits',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserCreditsPage()),
              );
            },
          ),
          // Options List
          _buildOptionTile(
            context,
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => const UserAccountPage2()),
              );
            },
          ),
          _buildOptionTile(
  context,
  icon: Icons.lock,
  title: 'Settings',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  },
),
          _buildOptionTile(
            context,
            icon: Icons.history,
            title: 'Activity Log',
            onTap: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ActivityLogPage()),
    );
            },
          ),
          _buildOptionTile(
            context,
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HelpSupportPage()),
    );
              // Navigate to Help & Support Page
            },
          ),

          const Divider(height: 40.0),

          // Sign Out Option
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              _showSignOutDialog(context);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showSignOutDialog(BuildContext context) {
  final authService = AuthService(); // Create an instance of AuthService

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await authService.signOut();

                // Clear entire navigation stack and go to Login page
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false, // Removes all previous routes
                );
              } catch (e) {
                print("Error during sign-out: $e");
              }
            },
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: const Center(
        child: Text('Explore Page Content'),
      ),
    );
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: const Center(
        child: Text('Saved Page Content'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});


    @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 16.0),

          // Account Settings Section
          const Text(
            'Account Settings',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildOptionTile(
            context,
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () {
              // Navigate to Edit Profile Page
            },
          ),
          _buildOptionTile(
            context,
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () {
              // Navigate to Change Password Page
            },
          ),

          const SizedBox(height: 24.0),

          // App Settings Section
          const Text(
            'App Settings',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildOptionTile(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              // Navigate to Notifications Settings Page
            },
          ),
          _buildOptionTile(
            context,
            icon: Icons.language,
            title: 'Language',
            onTap: () {
              // Navigate to Language Settings Page
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            secondary: const Icon(Icons.dark_mode),
          ),

          const SizedBox(height: 24.0),

          // Privacy Section
          const Text(
            'Privacy & Security',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildOptionTile(
            context,
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {
              // Navigate to Privacy Policy Page
            },
          ),
          _buildOptionTile(
            context,
            icon: Icons.shield,
            title: 'Terms & Conditions',
            onTap: () {
              // Navigate to Terms & Conditions Page
            },
          ),

          const SizedBox(height: 24.0),

          // About Section
          const Text(
            'About',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildOptionTile(
            context,
            icon: Icons.info,
            title: 'About Us',
            onTap: () {
              // Navigate to About Us Page
            },
          ),
          _buildOptionTile(
            context,
            icon: Icons.help_center,
            title: 'Help Center',
            onTap: () {
              // Navigate to Help Center Page
            },
          ),

          const SizedBox(height: 24.0),

          // Sign Out Option
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              _showSignOutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
      onTap: onTap,
    );
  }

 void _showSignOutDialog(BuildContext context) {
  final authService = AuthService(); // Create an instance of AuthService

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await authService.signOut();

                // Clear entire navigation stack and go to Login page
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false, // Removes all previous routes
                );
              } catch (e) {
                print("Error during sign-out: $e");
              }
            },
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
}


