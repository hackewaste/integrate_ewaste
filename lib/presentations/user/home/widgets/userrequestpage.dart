import 'package:flutter/material.dart';
import 'package:ewaste/presentations/user/detection/pickup_request_status_page.dart'; // Import the status page

class UserRequestsPage extends StatelessWidget {
  final List<Map<String, dynamic>> userRequests;

  UserRequestsPage({required this.userRequests});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Requests")),
      body: userRequests.isEmpty
          ? Center(child: Text("No requests found"))
          : ListView.builder(
              itemCount: userRequests.length,
              itemBuilder: (context, index) {
                var request = userRequests[index];

                return GestureDetector(
                  onTap: () {
                    // Navigate to PickupRequestStatusPage with requestId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PickupRequestStatusPage(
                          requestId: request['requestId'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Request ID: ${request['requestId']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: request['eWasteItems']
                                .map<Widget>((item) => Text(
                                      "${item['name']} - ${item['credits']} credits",
                                      style: TextStyle(fontSize: 16),
                                    ))
                                .toList(),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Total Credits: ${request['totalCredits']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text("Status: ${request['status']}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
