import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color white = Colors.white;
  static const Color textColor = Colors.black87;
  static const Color buttonColor = Color(0xFF388E3C);
}

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _selectedIndex = 2;
  int availableCredits = 2500;

  final List<Map<String, dynamic>> vouchers = [
    {"logo": "assets/amazon.png", "couponCode": "AMZ100", "creditsRequired": 1000},
    {"logo": "assets/flipkart.png", "couponCode": "FLIP500", "creditsRequired": 2000},
    {"logo": "assets/swiggy.png", "couponCode": "SWIGGY250", "creditsRequired": 1500},
    {"logo": "assets/zomato.png", "couponCode": "ZOMATO300", "creditsRequired": 1800},
    {"logo": "assets/myntra.png", "couponCode": "MYNTRA200", "creditsRequired": 1200},
  ];

  void _redeemVoucher(int requiredCredits, String couponCode) {
    if (availableCredits < requiredCredits) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Not enough credits!"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => availableCredits -= requiredCredits);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Coupon Redeemed: $couponCode"), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Rewards", style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Available Credits: $availableCredits", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                return VoucherCard(
                  logo: vouchers[index]['logo'],
                  couponCode: vouchers[index]['couponCode'],
                  creditsRequired: vouchers[index]['creditsRequired'],
                  onRedeem: () => _redeemVoucher(vouchers[index]['creditsRequired'], vouchers[index]['couponCode']),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "Rewards"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class VoucherCard extends StatelessWidget {
  final String logo;
  final String couponCode;
  final int creditsRequired;
  final VoidCallback onRedeem;

  const VoucherCard({
    required this.logo,
    required this.couponCode,
    required this.creditsRequired,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.asset(logo, width: 50, height: 50),
        title: Text("Coupon: $couponCode", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Credits Required: $creditsRequired"),
        trailing: ElevatedButton(
          onPressed: onRedeem,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor),
          child: Text("Redeem"),
        ),
      ),
    );
  }
}
