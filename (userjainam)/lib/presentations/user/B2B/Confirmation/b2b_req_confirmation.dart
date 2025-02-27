// request_confirmation_page.dart
import 'package:ewaste/presentations/user/B2B/Confirmation/widgets/info_section.dart';
import 'package:flutter/material.dart';


class B2bReqConfirmation extends StatelessWidget {
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

            InfoSection(requestId: requestId, expectedResponseTime: expectedResponseTime),

            SizedBox(height: 40),

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
}
