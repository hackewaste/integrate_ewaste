import 'package:flutter/material.dart';

class EwasteItem {
  final String itemName;
  final int quantity;
  final int creditPoints;

  EwasteItem({required this.itemName, required this.quantity, required this.creditPoints});

  static EwasteItem mockEwasteItem() {
    return EwasteItem(itemName: "Old Laptop", quantity: 2, creditPoints: 50);
  }
}
