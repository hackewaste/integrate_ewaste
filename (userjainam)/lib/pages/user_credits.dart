import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCreditsPage extends StatefulWidget {
  const UserCreditsPage({super.key});

  @override
  State<UserCreditsPage> createState() => _UserCreditsPageState();
}

class _UserCreditsPageState extends State<UserCreditsPage> {
  int userCredits = 0;

  @override
  void initState() {
    super.initState();
    fetchUserCredits();
  }

  // Fetch credits from the 'usercredits' collection
  Future<void> fetchUserCredits() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('usercredits').doc(user.uid).get();

      if (doc.exists) {
        setState(() {
          userCredits = doc.data()?['credits'] ?? 0;
        });
      } else {
        await FirebaseFirestore.instance.collection('usercredits').doc(user.uid).set({'credits': 0});
        setState(() {
          userCredits = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet History', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Wallet',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Unlock extra discounts on your orders',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_balance_wallet, color: Colors.white, size: 40),
                          const SizedBox(width: 10),
                          Text(
                            '₹$userCredits',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'Available Balance',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tabs or Sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildTab('How Credits Work', true),
                  const SizedBox(width: 10),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // How Wallet Works Section
            _buildInfoCard(
              number: '1',
              title: 'Earn Credits with Every Action',
              description:
                  'You can earn credits by participating in tasks or promotions. Credits are automatically added to your wallet.',
            ),
            const SizedBox(height: 10),
            _buildInfoCard(
              number: '2',
              title: 'Redeem for Exclusive Coupons',
              description:
                  'Use your credits to redeem coupons which can be applied on platforms like Amazon or Flipkart.',
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a tab
  Widget _buildTab(String title, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isActive ? null : Border.all(color: Colors.blue),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper method to build information cards
  Widget _buildInfoCard({
    required String number,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  number,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
