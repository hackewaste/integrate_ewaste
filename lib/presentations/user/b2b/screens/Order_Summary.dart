import 'package:flutter/material.dart';

class OrderSummaryPage extends StatelessWidget {
  final String businessName;
  final String organizationName;
  final String contactNumber;
  final String selectedMaterial;
  final int selectedQuantity;
  final String address;
  final bool isSpecialRequest;

  const OrderSummaryPage({
    super.key,
    required this.businessName,
    required this.organizationName,
    required this.contactNumber,
    required this.selectedMaterial,
    required this.selectedQuantity,
    required this.address,
    required this.isSpecialRequest,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard('Business Name', businessName),
            _buildSummaryCard('Organization Name', organizationName.isNotEmpty ? organizationName : 'N/A'),
            _buildSummaryCard('Contact Number', contactNumber),
            _buildSummaryCard('Selected Material', selectedMaterial),
            _buildSummaryCard('Quantity', '$selectedQuantity kg'),
            _buildSummaryCard('Address', address),
            _buildSummaryCard('Special Request', isSpecialRequest ? 'Yes' : 'No'),
            // _buildSummaryCard('Status', status), // Display order status
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Confirm Order', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
