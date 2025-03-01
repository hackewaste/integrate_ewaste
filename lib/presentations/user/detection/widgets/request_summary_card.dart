import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SummaryCard extends StatefulWidget {
  final String requestId;

  const SummaryCard({Key? key, required this.requestId}) : super(key: key);

  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  bool _isAddressExpanded = false;
  bool _isRequestIdExpanded = false;
  bool _isVolunteerNameExpanded = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').doc(widget.requestId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
          return const Center(child: Text("Request not found"));
        }

        var requestData = snapshot.data!.data() as Map<String, dynamic>?;
        if (requestData == null) {
          return const Center(child: Text("Invalid request data"));
        }

        String status = requestData['status']?.toString() ?? "pending";
        String? volunteerName = requestData['assignedVolunteerName']?.toString();
        //String requestId = requestData['requestId']?.toString() ?? "Unknown";
        String pickupAddress = requestData['pickupAddress']?['address'] ?? "Unknown Address";
        int totalCredits = requestData['totalCredits'] ?? 0;

        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.black26,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt_long, color: Colors.white, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      "Request Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Request ID - Expandable Tile
                _buildExpandableTile(
                  title: "Request ID",
                  value: widget.requestId,
                  isExpanded: _isRequestIdExpanded,
                  onTap: () {
                    setState(() {
                      _isRequestIdExpanded = !_isRequestIdExpanded;
                    });
                  },
                ),

                const SizedBox(height: 10),

                // Pickup Address - Expandable Tile
                _buildExpandableTile(
                  title: "Pickup Address",
                  value: pickupAddress,
                  isExpanded: _isAddressExpanded,
                  onTap: () {
                    setState(() {
                      _isAddressExpanded = !_isAddressExpanded;
                    });
                  },
                ),

                const SizedBox(height: 10),

                // Total Credits
                _buildDetailRow("💰 Total Credits", "$totalCredits points"),
                const SizedBox(height: 10),

                // Volunteer Name - Expandable Tile (If Assigned)
                if (volunteerName != null && (status == "assigned" || status == "picked"))
                  _buildExpandableTile(
                    title: "Volunteer Name",
                    value: volunteerName,
                    isExpanded: _isVolunteerNameExpanded,
                    onTap: () {
                      setState(() {
                        _isVolunteerNameExpanded = !_isVolunteerNameExpanded;
                      });
                    },
                  ),

                const SizedBox(height: 20),

                // Processing or Volunteer Assigned text
                Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(0.6),
                    highlightColor: Colors.white,
                    child: Text(
                      status == "assigned" ? "Volunteer Assigned" : "Processing your request...",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpandableTile({
    required String title,
    required String value,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
