import 'package:flutter/material.dart';

class StatusSection extends StatelessWidget {
  final String status;
  final String? volunteerName; // New Field

  const StatusSection({Key? key, required this.status, this.volunteerName}) : super(key: key);

  Color _getStatusColor() {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "assigned":
        return Colors.blue;
      case "picked":
        return Colors.purple;
      case "completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case "pending":
        return Icons.pending_actions;
      case "assigned":
        return Icons.assignment_ind;
      case "picked":
        return Icons.local_shipping;
      case "completed":
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusText() {
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
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: Colors.black26,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_getStatusColor().withOpacity(0.6), _getStatusColor()],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Icon(_getStatusIcon(), color: Colors.white, size: 30),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Status: ${status.toUpperCase()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _getStatusText(),
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
  }
}
