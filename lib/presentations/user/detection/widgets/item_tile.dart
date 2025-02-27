import 'package:flutter/material.dart';
import '../../../../data/models/ewaste_item.dart';

class ItemTile extends StatelessWidget {
  final EWasteItem item;

  const ItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    bool isHazardous = item.category.toLowerCase() == "hazardous";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        tileColor: isHazardous ? Colors.red.shade100 : Colors.blueGrey.shade50, // Adjusted contrast
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "${item.name} x ${item.count}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isHazardous ? Colors.red.shade900 : Colors.black, // Better text contrast
          ),
        ),
        trailing: Text(
          "${item.baseCredit * item.count} credits",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isHazardous ? Colors.red.shade700 : Colors.green,
          ),
        ),
      ),
    );
  }
}
