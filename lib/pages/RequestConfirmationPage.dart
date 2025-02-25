import 'package:flutter/material.dart';

class RequestConfirmationPage extends StatelessWidget {
  final String requestId = "REQ12345678";
  final String expectedResponseTime = "You'll be contacted within 24 hours.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Submitted'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Confirmation message with a check icon
            Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              "✅ Your Bulk Scrap Request has been submitted!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Request ID display
            _buildInfoSection(
              "Request ID:",
              requestId,
              Icons.receipt_long,
              Colors.deepPurple,
            ),

            // Expected response time display
            _buildInfoSection(
              "Expected Response Time:",
              expectedResponseTime,
              Icons.timer,
              Colors.orange,
            ),

            SizedBox(height: 40), // Space before the button

            // Button to View Request Status
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to Request Tracking Page
              },
              icon: Icon(Icons.track_changes, size: 20),
              label: Text("View Request Status"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to display sections like Request ID and Expected Response Time
  Widget _buildInfoSection(String title, String content, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 30),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 5),
              Text(
                content,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(home: RequestConfirmationPage()));
// }
