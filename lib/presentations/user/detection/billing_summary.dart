import 'package:ewaste/presentations/user/detection/widgets/category_tile.dart';
import 'package:ewaste/presentations/user/detection/widgets/credit_summary.dart';
import 'package:ewaste/presentations/user/detection/widgets/location_tile.dart';
import 'package:ewaste/presentations/user/detection/widgets/payment_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/selected_items_provider.dart';


class BillingSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedItemsProvider = Provider.of<SelectedItemsProvider>(context);
    var selectedItems = selectedItemsProvider.selectedItems;

    return Scaffold(
      appBar: AppBar(title: Text("Billing Summary")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            LocationWidget(), // 🏠 Location Tile Component
            SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: selectedItems.entries.map((entry) =>
                    CategoryTile(entry: entry)
                ).toList(),
              ),
            ),
            CreditSummary(provider: selectedItemsProvider), // 💳 Credit Summary
            SizedBox(height: 15),
            PaymentButton(),
            SizedBox(height: 15),// 💰 Payment Button
          ],
        ),
      ),
    );
  }
}
