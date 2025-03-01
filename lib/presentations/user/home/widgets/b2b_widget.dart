import 'package:flutter/material.dart';
import 'package:ewaste/presentations/user/b2b/screens/bulk_scrap_request.dart';

Widget B2BPostSection(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BulkScrapRequestPage()),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[50]!, Colors.green[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.green[200]!,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with B2B tag and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'B2B',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Business E-Waste Solution',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Description
          const Text(
            'Specialized services for corporate electronic waste disposal and recycling of office equipment',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 16),

          // Main content with image and button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              Flexible(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/delivery.png",
                    height: 100, // Reduced image size
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Right side with features and button
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeatureItem(Icons.business, 'Bulk disposal'),
                    const SizedBox(height: 6),
                    _buildFeatureItem(Icons.local_shipping, 'On-site pickup'),
                    const SizedBox(height: 6),
                    _buildFeatureItem(Icons.assignment, 'Compliance reports'),

                    const SizedBox(height: 12),

                    // CTA Button
                    SizedBox(
                      width: double.infinity, // Ensures the button is well-placed
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BulkScrapRequestPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Request Service'),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Bottom info note
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.green[700], size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Ideal for offices, schools, and organizations with large quantities of e-waste',
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Feature item widget
Widget _buildFeatureItem(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 16, color: Colors.green[700]),
      const SizedBox(width: 6),
      Expanded( // Prevents text overflow
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
