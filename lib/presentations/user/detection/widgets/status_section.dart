import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusSection extends StatelessWidget {
  final String requestId; // Fetch data using requestId

  const StatusSection({Key? key, required this.requestId}) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "assigned":
        return Colors.blue;
      case "verified":
        return Colors.purple;
      case "pickedup":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "pending":
        return Icons.pending_actions;
      case "assigned":
        return Icons.assignment_ind;
      case "verfied":
        return Icons.local_shipping;
      case "pickedup":
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "pending":
        return "Waiting for Assignment";
      case "assigned":
        return "Volunteer Assigned";
      case "picked":
        return "On the Way";
      case "completed":
        return "Request Completed";
      default:
        return "Unknown Status";
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').doc(requestId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
          return const Center(
            child: Text("Request not found", style: TextStyle(color: Colors.white)),
          );
        }

        var requestData = snapshot.data!.data() as Map<String, dynamic>?;

        if (requestData == null) {
          return const Center(
            child: Text("Invalid request data", style: TextStyle(color: Colors.white)),
          );
        }

        // Safely extract status and volunteerName
        String status = requestData['status']?.toString() ?? "pending";
        String? volunteerName = requestData['assignedVolunteerName']?.toString();

        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.black26,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_getStatusColor(status).withOpacity(0.6), _getStatusColor(status)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Icon(_getStatusIcon(status), color: Colors.white, size: 30),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status: ${status.toUpperCase()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _getStatusText(status),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    if (volunteerName != null && (status == "assigned" || status == "picked")) ...[
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.person, size: 16, color: Colors.white.withOpacity(0.9)),
                          const SizedBox(width: 5),
                          Text(
                            "Volunteer: $volunteerName",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
