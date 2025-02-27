
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'package:ewaste/presentations/user/home/userHomePage.dart';
import 'package:ewaste/pages/dropImage.dart';
import 'package:ewaste/pages/info.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  int _currentIndex= 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigation logic for each tab
    switch (index) {
      case 0: // Home
      // Stay on the current Home page
        break;
      case 1: // Explore
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InfoPage()),
        );
        break;
      case 2: // Saved
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const BadgesWidget()), // Navigate to UserAccountPage
        // );
        break;
      case 3: // Profile (Redirect to Home)
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const UserAccountPage(title: 'User Profile',)), // Navigate to UserAccountPage
        // );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notifications')
                .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where('read', isEqualTo: false) // Only fetch unread notifications
                .snapshots(),
            builder: (context, snapshot) {
              int unreadCount = snapshot.data?.docs.length ?? 0;
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => NotificationPage()),
                      // );
                    },
                  ),
                  if (unreadCount > 0) // Only show if there are unread notifications
                    Positioned(
                      right: 10,
                      top: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 8,
                        child: Text(
                          unreadCount.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(context),
              const SizedBox(height: 24.0),
              UpcomingEventsSection(),
              const SizedBox(height: 24.0),
              StepsSection(),
              const SizedBox(height: 24.0),
              B2BPostSection(),
              const SizedBox(height: 24.0),
              InviteSection(),
              const SizedBox(height: 24.0),
              buildDateSelector(),
              const SizedBox(height: 24.0),
              buildDailyActivity(context), // Pass context here
            ],
          ),
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
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

Widget HeaderSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.green[100],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Join us in creating a cleaner, greener future—donate your e-waste today and make a lasting impact on the environment!',
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetectionPage()),
            );
          },
          child: const Text('Sell Now'),
        ),
      ],
    ),
  );
}

Widget UpcomingEventsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Upcoming Events',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('See All'),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      Row(
        children: [
          Expanded(
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/download.jpg',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Sell e-waste for business co-op',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/download1.jpg',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Sell e-waste for business co-op',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget StepsSection() {
  return Container(
    padding: const EdgeInsets.all(1.0),
    decoration: BoxDecoration(
      color: Colors.amber[50],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        StepBox(
          imagePath: 'assets/man.png',
          label: 'Get Pickup e-waste',
        ),
        StepBox(
          imagePath: 'assets/priority-list.png',
          label: 'Enter category',
        ),
        StepBox(
          imagePath: 'assets/submit.png',
          label: 'Submit',
        ),
      ],
    ),
  );
}


Widget B2BPostSection() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.green[50],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Bulk Scrap Request',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See All',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images.png',
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Bulk Scrap Request For Industries',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Make it easy for yourself to sell your scrap.',
                            style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Sell Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images.png',
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Bulk Scrap Request For Modern Needs',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Effortlessly request and manage your scrap sales.',
                            style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Sell Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget InviteSection() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
            'Earn tokens for each friend invited who makes a donation'),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Invite Now'),
        ),
      ],
    ),
  );
}

Widget OverallStatisticsSection() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overall statistics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF324F5E),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 8,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _buildBarGroup(0, 6, Colors.green),
                  _buildBarGroup(1, 4, Colors.red),
                  _buildBarGroup(2, 7, Colors.amber),
                  _buildBarGroup(3, 5, Colors.green),
                  _buildBarGroup(4, 3, Colors.red),
                  _buildBarGroup(5, 4, Colors.green),
                  _buildBarGroup(6, 5, Colors.amber),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

BarChartGroupData _buildBarGroup(int x, double y, Color color) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        fromY: 0,           // Starting point of the bar (can be 0 or any other value)
        toY: y,             // Ending point of the bar (replace 'y' with the actual value, it should be a valid double)
        color: color,       // The color of the bar
        width: 20,          // The width of the bar
        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)), // Styling the bar's top border
      )
    ],
  );
}

Widget buildDateSelector() {
  final now = DateTime.now();
  final dates = List.generate(7, (index) => now.add(Duration(days: index)));

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: dates.map((date) {
      final isToday = date.day == now.day;
      final textColor = isToday ? Colors.orange : const Color(0xFF324F5E);
      final bgColor = isToday ? Colors.orange : Colors.transparent;

      return Column(
        children: [
          Text(
            DateFormat('EEE').format(date),
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 4),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: isToday ? Colors.white : textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }).toList(),
  );
}

Widget buildDailyActivity(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: 0.75,
                      strokeWidth: 10,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        '20',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF324F5E),
                        ),
                      ),
                      Text(
                        'June',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF324F5E),
                  ),
                ),
                const SizedBox(height: 10),
                _buildActivityLegendItem('Ewaste', Colors.green),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
           onPressed: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const HomePage()),
          //   );
          },
          child: const Text(
            'View More',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildActivityLegendItem(String label, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
class StepBox extends StatelessWidget {
  final String imagePath;
  final String label;

  const StepBox({
    super.key,
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 50.0,
          width: 50.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8.0),
        Text(label, textAlign: TextAlign.center),
      ],
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
