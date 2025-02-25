import 'package:flutter/material.dart';
import 'UserHomepage.dart';
import 'package:ewaste/pages/info.dart';
import 'package:ewaste/services/auth_service.dart'; // Import the AuthService
import 'package:ewaste/pages/login.dart'; // Import the Login page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Account',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserAccountPage(),
    );
  }
}

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key});

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  int _currentIndex = 3; // Set "Profile" as the default tab

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigation logic for each tab
    switch (index) {
      case 0: // Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserHomepage()),
        );
        break;
      case 1: // Explore
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExplorePage()),
        );
        break;
      case 2: // Saved
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SavedPage()),
        );
        break;
      case 3: // Profile
        break; // Already on Profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Section
            Hero(
  tag: 'profile-pic',
  child: CircleAvatar(
    radius: 60.0,
    backgroundImage: const AssetImage('assets/volunteer.png'),
    onBackgroundImageError: (_, __) {
      print("Error loading profile picture. Using fallback.");
    },
    child: const Icon(Icons.person, size: 60), // Fallback image
  ),
),
            const SizedBox(height: 12.0),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              'john.doe@example.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24.0),

            // Options Section
            _buildOptionTile(
              icon: Icons.person,
              title: 'Edit Profile',
              subtitle: 'Update your account information',
              onTap: () {
                // Navigate to Edit Profile Page
              },
            ),
            _buildOptionTile(
              icon: Icons.lock,
              title: 'Privacy Settings',
              subtitle: 'Manage your data and permissions',
              onTap: () {
                // Navigate to Privacy Settings Page
              },
            ),
            _buildOptionTile(
              icon: Icons.history,
              title: 'Activity Log',
              subtitle: 'View your recent activity',
              onTap: () {
                // Navigate to Activity Log Page
              },
            ),
            _buildOptionTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'Get assistance with your account',
              onTap: () {
                // Navigate to Help & Support Page
              },
            ),
            const SizedBox(height: 16.0),

            // Sign Out Button
            ElevatedButton.icon(
              onPressed: () {
                _showSignOutDialog(context);
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                textStyle: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
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

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
        onTap: onTap,
      ),
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

// Placeholder Pages
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Home Page Content')),
    );
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: const Center(child: Text('Explore Page Content')),
    );
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: const Center(child: Text('Saved Page Content')),
    );
  }
}
