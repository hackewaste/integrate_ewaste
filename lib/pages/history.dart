import 'package:flutter/material.dart';
import 'theme.dart';
import 'color.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedIndex = 3; // Default to History tab

  final List<Map<String, dynamic>> redeemedCoupons = [
    {
      'logo': 'assets/amazon.png',
      'couponCode': 'AMZ-2024-XYZ123',
      'date': 'Feb 20, 2025',
    },
    {
      'logo': 'assets/flipkart.png',
      'couponCode': 'FLIP-2024-ABC456',
      'date': 'Feb 18, 2025',
    },
    {
      'logo': 'assets/swiggy.png',
      'couponCode': 'SWIGGY-2024-PQR789',
      'date': 'Feb 15, 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          children: [
            Container(
              color: AppColors.statusBarColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('1:09', style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      const Text('25%', style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 4),
                      Icon(Icons.battery_3_bar, color: Colors.white.withOpacity(0.8)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.primary,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: redeemedCoupons.length,
        itemBuilder: (context, index) {
          return HistoryCard(
            logo: redeemedCoupons[index]['logo'],
            couponCode: redeemedCoupons[index]['couponCode'],
            date: redeemedCoupons[index]['date'],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.bg300,
        backgroundColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Trial'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Rewards'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String logo;
  final String couponCode;
  final String date;

  const HistoryCard({
    super.key,
    required this.logo,
    required this.couponCode,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bg200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary200),
      ),
      child: Row(
        children: [
          Image.asset(logo, width: 64, height: 64),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coupon Code: $couponCode',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Redeemed on $date',
                  style: TextStyle(color: AppColors.text200),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
