import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../presentations/user/user_bottom_navigation.dart';
import 'contacts-list.dart';
import 'redeem.dart';
import 'history.dart';

class EarnPage extends StatefulWidget {
  const EarnPage({super.key});

  @override
  State<EarnPage> createState() => _EarnPageState();
}

class _EarnPageState extends State<EarnPage> {
  int _selectedIndex = 0;

  // Fetch user's credits from Firestore
  Future<int> _fetchUserCredits() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return 0; // If no user is logged in, return 0 credits.

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();

    return userDoc.exists ? userDoc['credits'] ?? 0 : 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.amber[100],
              child: const Text('😊', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<int>(
                  future: _fetchUserCredits(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        'Error',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    } else {
                      return Text(
                        '${snapshot.data} Bucks',
                        style: TextStyle(
                          color: Colors.purple[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    }
                  },
                ),
                const Text(
                  'Available →',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation Tabs
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(1, 'Earn', Icons.more_horiz),
                  _buildNavItem(2, 'Redeem', Icons.check_circle_outline),
                  _buildNavItem(3, 'History', Icons.history),
                ],
              ),
            ),

            // Earn & Win Card
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[200]!, Colors.purple[300]!],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Earn E-Waste Points In 2 Steps',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStepCard(
                            'Unlock 20 E-Waste Credits*',
                            'when you recycle your e-waste',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStepCard(
                            'Earn 200 E-Waste Credits*',
                            'on successful e-waste pickup request',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
<<<<<<< HEAD
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[100],
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Redeem'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
=======
        bottomNavigationBar: UserBottomNavigation(currentIndex: 2,)
>>>>>>> 220571d6d8dc5cae23cca353664c8e98f2429829
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (label == 'Redeem') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RewardsScreen()),
          );
        } else if (label == 'History') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryScreen()),
          );
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.brown[100] : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.brown : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
