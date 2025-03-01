import 'package:ewaste/presentations/user/detection/billing_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/manual_entry_card.dart';
import 'widgets/ai_detection_card.dart';

class DetectionPageF extends StatelessWidget {

  void _startAIDetection() {
    // Implement AI detection logic
    print("AI detection started...");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detection")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AIDetectionCard(),
            ManualEntryCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BillingSummary()));
        },
      ),
    );
  }
}



