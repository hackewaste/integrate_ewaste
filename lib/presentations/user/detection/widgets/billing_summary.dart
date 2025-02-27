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
      body: Column(
        children: [
          Text("Total Credits: ${selectedItemsProvider.getTotalCredits()}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView(
              children: selectedItems.entries.map((entry) {
                return ExpansionTile(
                  title: Text(entry.key, style: TextStyle(fontSize: 16)),
                  children: entry.value.map((item) {
                    return ListTile(
                      title: Text("${item.name} x ${item.count}"),
                      trailing: Text("${item.baseCredit * item.count} credits"),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
