import 'package:ewaste/data/models/ewaste_item.dart';
import 'package:flutter/material.dart';
import 'item_tile.dart';

class CategoryTile extends StatelessWidget {
  final MapEntry<String, List<EWasteItem>> entry;

  const CategoryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    bool isHazardous = entry.key.toLowerCase() == "hazardous"; // Check if category is hazardous

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: isHazardous ? Colors.red.shade100 : Colors.blueGrey.shade50, // Change color if hazardous
      child: ExpansionTile(
        title: Text(
          entry.key,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isHazardous ? Colors.red : Colors.black, // Change text color for better contrast
          ),
        ),
        backgroundColor: isHazardous ? Colors.red.shade100 : Colors.blueGrey.shade50, // Adjust background
        collapsedBackgroundColor: isHazardous ? Colors.red.shade200 : Colors.blueGrey.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Remove top/bottom black lines
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        children: entry.value.map((item) => ItemTile(item: item)).toList(),
      ),
    );
  }
}
