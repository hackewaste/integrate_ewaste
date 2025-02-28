import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/models/request_model.dart';

class SummaryCard extends StatefulWidget {
  final RequestModel request;
  final String? volunteerName; // New field

  const SummaryCard({Key? key, required this.request, this.volunteerName}) : super(key: key);

  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  bool _isAddressExpanded = false;
  bool _isRequestIdExpanded = false;

  @override
  Widget build(BuildContext context) {
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
              value: widget.request.requestId,
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
              value: widget.request.pickupAddress.address,
              isExpanded: _isAddressExpanded,
              onTap: () {
                setState(() {
                  _isAddressExpanded = !_isAddressExpanded;
                });
              },
            ),

            const SizedBox(height: 10),

            // Total Credits
            _buildDetailRow("💰 Total Credits", "${widget.request.totalCredits} points"),
            const SizedBox(height: 10),

            // Show Volunteer Name if Assigned
            if (widget.volunteerName != null &&
                (widget.request.status == "assigned" || widget.request.status == "picked"))
              _buildDetailRow("👤 Volunteer", widget.volunteerName!),

            const SizedBox(height: 20),

            // Processing Shimmer
            Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.6),
                highlightColor: Colors.white,
                child: Text(
                  "Processing your request...",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
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
