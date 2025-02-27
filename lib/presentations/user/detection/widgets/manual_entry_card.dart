import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/ewaste_item.dart';
import '../../../../data/models/selected_items_provider.dart';
import '../../../../data/services/detection_billing_services.dart';

class ManualEntryCard extends StatefulWidget {
  @override
  _ManualEntryCardState createState() => _ManualEntryCardState();
}

class _ManualEntryCardState extends State<ManualEntryCard> {
  List<EWasteItem> items = [];

  @override
  void initState() {
    super.initState();
    FirebaseService.fetchEWasteItems().then((fetchedItems) {
      setState(() {
        items = fetchedItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedItemsProvider = Provider.of<SelectedItemsProvider>(context);

    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Manual Entry",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            for (var item in items.take(7))
              _buildItemRow(item, selectedItemsProvider),
            if (items.length > 7)
              Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: const Text(
                    "Others",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  children: items.skip(7).map((item) {
                    return _buildItemRow(item, selectedItemsProvider, isExpanded: true);
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(EWasteItem item, SelectedItemsProvider provider, {bool isExpanded = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: isExpanded ? 12 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.name,
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                onPressed: () => provider.removeItem(item),
              ),
              Text(
                item.count.toString(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                onPressed: () => provider.addItem(item),
              ),
            ],
          ),
        ],
      ),
    );
  }
}