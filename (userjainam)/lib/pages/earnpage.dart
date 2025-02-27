import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const EarnPage(),  // Use EarnPage as the home screen
    );
  }
}

class EarnPage extends StatefulWidget {
  const EarnPage({super.key});

  @override
  State<EarnPage> createState() => _EarnPageState();
}

class _EarnPageState extends State<EarnPage> {
  int _selectedIndex = 0;

  // Bottom navigation onTap logic
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
                Text(
                  '45 Bucks', // User's credits
                  style: TextStyle(
                    color: Colors.purple[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
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
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.calendar_today, color: Colors.black),
          ),
        ],
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
                  _buildNavItem(1, 'Earn', Icons.more_horiz), // 'Earn' instead of 'Home'
                  _buildNavItem(2, 'Redeem', Icons.check_circle_outline),
                  _buildNavItem(3, 'History', Icons.history),
                ],
              ),
            ),

            // Earn & Win Card (Updated with e-waste terminology)
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
                            'Take a Quiz',
                            '',
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

            // Refer & Earn Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Refer & Earn BIG',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black87),
                      children: [
                        const TextSpan(text: 'Earn '),
                        TextSpan(
                          text: '₹200*',
                          style: TextStyle(
                            color: Colors.blue[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ' for every friend who joins the e-waste recycling platform.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildShareButton(FontAwesomeIcons.whatsapp, Colors.green), // For WhatsApp
                      _buildShareButton(Icons.telegram, Colors.blue),
                      _buildShareButton(Icons.share, Colors.grey),
                      _buildShareButton(Icons.copy, Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.person, color: Colors.black54),
                        SizedBox(width: 8),
                        Text(
                          'Find in your contacts',
                          style: TextStyle(color: Colors.black87),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward, color: Colors.black54),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped, // Use separate function for onTap
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'), // Explore
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Redeem'), // Redeem
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), // Profile
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    final isSelected = _selectedIndex == index;
    return Column(
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

  Widget _buildShareButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }
}