import 'package:flutter/material.dart';
import 'package:ewaste/pages/earnpage.dart';
import 'package:ewaste/pages/history.dart';

// Add the color scheme class
class AppColors {
  // Background Colors
  static const Color background = Color(0xFFFFFDF9); // Light Cream
  static const Color bg200 = Color(0xFFF5F3EF); // Off-white
  static const Color bg300 = Color(0xFFD9D9D9); // Light Gray

  // Primary Colors (Soft Green)
  static const Color primary = Color(0xFF81C784); // Soft Green
  static const Color primary200 = Color(0xFFAED581); // Light Green
  static const Color primary300 = Color(0xFFDCE775); // Yellowish Green

  // Accent Colors (Bright & Energetic)
  static const Color accent = Color(0xFFFFB703); // Bright Yellow
  static const Color accent200 = Color(0xFFF57F17); // Deep Orange
  static const Color accent300 = Color(0xFFFF7043); // Warm Orange

  // Additional Colors (Contrast & Highlights)
  static const Color red = Color(0xFFD62828); // Deep Red
  static const Color blue = Color(0xFF0077B6); // Electric Blue
  static const Color black = Color(0xFF333333); // Dark Grayish Black

  // Text Colors
  static const Color text = Color(0xFF4E342E); // Brownish Gray for readability
  static const Color text200 = Color(0xFF6D4C41); // Softer Brown
  static const Color textAlt = Color(0xFF1565C0); // Brighter Blue for contrast

  // Status Bar & App Bar Colors
  static const Color statusBarColor = Color(0xFF558B2F); // Dark Greenish tone
  static const Color appBarColor = Color(0xFF37474F); // Dark Blue-Grey

  // Navigation Colors
  static const Color selectedNavColor = Color(0xFF2E7D32); // Deep Green
  static const Color unselectedNavColor = Color(0xFFBDBDBD); // Light Grayish tone

  // Card Colors
  static const Color cardBackground = Color(0xFFE8F5E9); // Very light green shade
}

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _selectedIndex = 2; // Default selected tab
  int availableCredits = 45; // Example: User's available credits
int _currentIndex = 0;
void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  // Company details with unique coupon codes
  final List<Map<String, dynamic>> vouchers = [
    {
      'logo': 'assets/amazon.png',
      'couponCode': 'AMZ-2024-XYZ123',
      'creditsRequired': 20,
    },
    {
      'logo': 'assets/flipkart.png',
      'couponCode': 'FLIP-2024-ABC456',
      'creditsRequired': 30,
    },
    {
      'logo': 'assets/swiggy.png',
      'couponCode': 'SWIGGY-2024-PQR789',
      'creditsRequired': 25,
    },
    {
      'logo': 'assets/zomato.png',
      'couponCode': 'ZOMATO-2024-DEF321',
      'creditsRequired': 35,
    },
    {
      'logo': 'assets/myntra.png',
      'couponCode': 'MYNTRA-2024-LMN654',
      'creditsRequired': 40,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          children: [
            // Custom Status Bar
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
            // Custom App Bar
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.appBarColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(child: Text('🪙', style: TextStyle(fontSize: 20))),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$availableCredits Credits',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Available →',
                            style: TextStyle(color: AppColors.bg200, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.card_giftcard_outlined, color: AppColors.accent),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Navigation Bar
          Container(
  padding: const EdgeInsets.symmetric(vertical: 12),
  color: AppColors.bg200,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _buildNavItem(Icons.more_horiz, 'Earn', 1, onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EarnPage()),
        );
      }),
      _buildNavItem(Icons.card_giftcard, 'Redeem', 2, isSelected: true),
      _buildNavItem(Icons.history, 'History', 3, onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoryScreen()),
        );
      }),
    ],
  ),
),
          Divider(height: 1, color: AppColors.bg300),
          // Voucher List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                return VoucherCard(
                  logo: vouchers[index]['logo'],
                  couponCode: vouchers[index]['couponCode'],
                  creditsRequired: vouchers[index]['creditsRequired'],
                  availableCredits: availableCredits,
                  onRedeem: () {
                    setState(() {
                      int requiredCredits = vouchers[index]['creditsRequired'] as int;
                      if (availableCredits >= requiredCredits) {
                        availableCredits -= requiredCredits;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "🎉 Coupon Redeemed! Use Code: ${vouchers[index]['couponCode']}",
                            ),
                            backgroundColor: AppColors.primary,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("❌ Not enough credits!"),
                            backgroundColor: AppColors.red,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),
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
  Widget _buildNavItem(IconData icon, String label, int index, 
    {bool isSelected = false, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap, // Execute the onTap function when tapped
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary200 : AppColors.bg300,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isSelected
                ? AppColors.selectedNavColor
                : AppColors.unselectedNavColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected
                ? AppColors.selectedNavColor
                : AppColors.unselectedNavColor,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

// Voucher Card UI
class VoucherCard extends StatelessWidget {
  final String logo;
  final String couponCode;
  final int creditsRequired;
  final int availableCredits;
  final VoidCallback onRedeem;

  const VoucherCard({
    super.key,
    required this.logo,
    required this.couponCode,
    required this.creditsRequired,
    required this.availableCredits,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.bg300),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(logo, width: 64, height: 64), // Company Logo
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Redeem for $creditsRequired Credits',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bg200,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: availableCredits >= creditsRequired ? onRedeem : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: availableCredits >= creditsRequired 
                          ? AppColors.primary 
                          : AppColors.bg300,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Redeem Now',
                      style: TextStyle(
                        color: availableCredits >= creditsRequired 
                            ? Colors.white 
                            : AppColors.text200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}