import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'history.dart';

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int userCredits = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserCredits();
  }

  Future<void> _fetchUserCredits() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();

    if (userDoc.exists) {
      setState(() {
        userCredits = userDoc['credits'] ?? 0;
      });
    }
  }

  Future<void> _redeemVoucher(int requiredCredits, String couponCode) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (userCredits < requiredCredits) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Not enough credits!"), backgroundColor: Colors.red),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
      'credits': userCredits - requiredCredits,
    });

    setState(() => userCredits -= requiredCredits);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Coupon Redeemed: $couponCode"), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Rewards", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[400],
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchUserCredits,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Available Credits: $userCredits", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildVoucherCard("Amazon", "assets/amazon.png", "AMZ100", 1000),
                _buildVoucherCard("Flipkart", "assets/flipkart.png", "FLIP500", 2000),
                _buildVoucherCard("Swiggy", "assets/swiggy.png", "SWIGGY250", 1500),
                _buildVoucherCard("Zomato", "assets/zomato.png", "ZOMATO300", 1800),
                _buildVoucherCard("Myntra", "assets/myntra.png", "MYNTRA200", 1200),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherCard(String name, String logo, String couponCode, int creditsRequired) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.asset(logo, width: 50, height: 50),
        title: Text("$name Coupon: $couponCode", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Credits Required: $creditsRequired"),
        trailing: ElevatedButton(
          onPressed: () => _redeemVoucher(creditsRequired, couponCode),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[400]),
          child: Text("Redeem"),
        ),
      ),
    );
  }
}
