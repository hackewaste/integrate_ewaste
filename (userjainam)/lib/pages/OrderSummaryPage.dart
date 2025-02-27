import 'package:flutter/material.dart';
// import 'package:homepage/BulkScrapRequestPage.dart';


class OrderSummaryPage extends StatelessWidget {
  final String companyName = "Tech Innovations";
  final String contactPerson = "John Doe";
  final String phoneNumber = "+1234567890";
  final String email = "johndoe@example.com";
  final String scrapType = "Metal";
  final String scrapQuantity = "500 KG";
  final String condition = "Used";
  final String pickupAddress = "123 Tech Street, Silicon Valley";
  final String pickupDate = "2025-03-01";
  final String pickupTime = "10:00 AM";
  final bool assistanceRequired = true;
  final String paymentMode = "UPI";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Business Details Section
            _buildSectionTitle('Business Information'),
            _buildDetailsCard([
              'Company Name: $companyName',
              'Contact Person: $contactPerson',
              'Phone: $phoneNumber',
              'Email: $email',
            ]),

            // Scrap Details Section
            _buildSectionTitle('Scrap Details'),
            _buildDetailsCard([
              'Type of Scrap: $scrapType',
              'Quantity: $scrapQuantity',
              'Condition: $condition',
            ]),

            // Pickup Details Section
            _buildSectionTitle('Pickup Details'),
            _buildDetailsCard([
              'Address: $pickupAddress',
              'Pickup Date: $pickupDate',
              'Pickup Time: $pickupTime',
              'Assistance Required: ${assistanceRequired ? "Yes" : "No"}',
            ]),


            // Edit and Confirm Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to edit page
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: Icon(Icons.check_circle),
                  label: Text('Confirm Request'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailsCard(List<String> details) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details
              .map((detail) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      detail,
                      style: TextStyle(fontSize: 16),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

