import 'package:flutter/material.dart';
import '../models/ewaste_item.dart';

class SelectedItemsProvider extends ChangeNotifier {
  final Map<String, List<EWasteItem>> selectedItems = {}; // {category: [items]}

  void addItem(EWasteItem item) {
    selectedItems.putIfAbsent(item.category, () => []);
    var existingItem = selectedItems[item.category]!.firstWhere(
          (e) => e.name == item.name,
      orElse: () => EWasteItem(name: '', category: '', baseCredit: 0),
    );

    if (existingItem.name.isNotEmpty) {
      existingItem.count++;
    } else {
      item.count = 1;
      selectedItems[item.category]!.add(item);
    }
    notifyListeners();
  }

  void removeItem(EWasteItem item) {
    if (selectedItems.containsKey(item.category)) {
      var categoryItems = selectedItems[item.category]!;

      int index = categoryItems.indexWhere((e) => e.name == item.name);
      if (index != -1) {
        if (categoryItems[index].count > 1) {
          categoryItems[index] = categoryItems[index].copyWith(count: categoryItems[index].count - 1);
        } else {
          categoryItems.removeAt(index); // Remove item completely if count reaches 0
        }
      }

      // If category is empty, remove it from the map
      if (categoryItems.isEmpty) {
        selectedItems.remove(item.category);
      }

      notifyListeners(); // Ensure UI updates
    }
  }



  int getTotalCredits() {
    int total = 0;
    selectedItems.forEach((_, items) {
      for (var item in items) {
        total += item.baseCredit * item.count;
      }
    });
    return total;
  }
}
