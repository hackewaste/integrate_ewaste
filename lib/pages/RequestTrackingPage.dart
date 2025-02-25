import 'package:flutter/material.dart';

class RequestTrackingPage extends StatefulWidget {
  @override
  _RequestTrackingPageState createState() => _RequestTrackingPageState();
}

class _RequestTrackingPageState extends State<RequestTrackingPage> {
  final String requestId = "REQ12345678";
  String status = "Scheduled"; // Example: Status changes like Pending, Approved, etc.
  final String assignedAgent = "John Smith";
  final String agentPhone = "+1234567890";
  final String agentEmail = "johnsmith@example.com";
  final String expectedPickupDate = "2025-03-01 10:00 AM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Tracking'),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoSection(
                "Request ID",
                requestId,
                Icons.receipt_long,
                Colors.blueGrey,
              ),
              SizedBox(height: 20),
              _buildAnimatedStatusSection(),
              SizedBox(height: 20),
              _buildAgentDetailsSection(),
              SizedBox(height: 20),
              _buildRescheduleCancelSection(),
              SizedBox(height: 20),
              _buildContactHelpSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Request ID and Basic Info
  Widget _buildInfoSection(String title, String content, IconData icon, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 28),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              SizedBox(height: 6),
              Text(
                content,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Animated Status Update Section with Rotating Icon and Scaling Text
  Widget _buildAnimatedStatusSection() {
    Color statusColor = _getStatusColor(status);

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: Card(
        key: ValueKey<String>(status), // Using status as key to trigger animation on status change
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Rotating Icon
                  AnimatedRotation(
                    turns: status == "Scheduled" ? 0.0 : 0.5,
                    duration: Duration(seconds: 1),
                    child: Icon(Icons.access_time, color: statusColor, size: 30),
                  ),
                  SizedBox(width: 12),
                  // Scaling Status Text
                  AnimatedScale(
                    scale: status == "Scheduled" ? 1.0 : 1.2,
                    duration: Duration(seconds: 1),
                    child: Text(
                      "Status: $status",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: statusColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                "Your request is currently in the '$status' stage. We are processing your request.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 15),
              _buildProgressBar(),
            ],
          ),
        ),
      ),
    );
  }

  // Animated Progress Bar Widget
  Widget _buildProgressBar() {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      height: 6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: _getProgressValue(status),
        child: Container(
          decoration: BoxDecoration(
            color: _getStatusColor(status),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // Helper function to get status color
  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Approved":
        return Colors.green;
      case "Scheduled":
        return Colors.blue;
      case "Picked Up":
        return Colors.yellow;
      case "Completed":
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  // Returns progress value based on status
  double _getProgressValue(String status) {
    switch (status) {
      case "Pending":
        return 0.1;
      case "Approved":
        return 0.3;
      case "Scheduled":
        return 0.5;
      case "Picked Up":
        return 0.8;
      case "Completed":
        return 1.0;
      default:
        return 0.0;
    }
  }

  // Assigned Agent Details Section
  Widget _buildAgentDetailsSection() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 500),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assigned Agent: $assignedAgent",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              Text(
                "Phone: $agentPhone",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              Text(
                "Email: $agentEmail",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  // Action to call or open email
                },
                icon: Icon(Icons.contact_phone),
                label: Text("Contact Agent"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reschedule or Cancel Section
  Widget _buildRescheduleCancelSection() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pickup Date & Time:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              Text(
                expectedPickupDate,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to reschedule page
                    },
                    icon: Icon(Icons.schedule),
                    label: Text("Reschedule"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action to cancel the request
                    },
                    icon: Icon(Icons.cancel),
                    label: Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Contact Help Section
  Widget _buildContactHelpSection() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(seconds: 1),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Need Help?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // Open chat support or contact page
                },
                icon: Icon(Icons.chat),
                label: Text("Chat with Support"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(home: RequestTrackingPage()));
// }

