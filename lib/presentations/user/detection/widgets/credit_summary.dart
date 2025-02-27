import 'package:flutter/material.dart';
import '../../../../data/models/selected_items_provider.dart';

class CreditSummary extends StatelessWidget {
  final SelectedItemsProvider provider;

  const CreditSummary({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Credit Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Items", style: TextStyle(fontSize: 16)),
                Text("${provider.getTotalItems()} items", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Credits", style: TextStyle(fontSize: 16)),
                Text("${provider.getTotalCredits()} credits", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
