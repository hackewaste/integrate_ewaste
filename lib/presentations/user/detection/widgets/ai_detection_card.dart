import 'package:flutter/material.dart';

class AIDetectionCard extends StatelessWidget {
  final VoidCallback onDetect;

  const AIDetectionCard({super.key, required this.onDetect});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "AI Detection",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Automatically detect e-waste items using AI."),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton.icon(
                onPressed: onDetect,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Start Scanning"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
