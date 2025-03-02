import 'package:flutter/material.dart';
import '../../../data/models/resale_item.dart';
import '../../../data/services/resale_service.dart';


class ResaleCard extends StatelessWidget {
  final ResaleItem item;
  ResaleCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("₹${item.price}"),
        trailing: ElevatedButton(
          onPressed: () {
            ResaleService().requestToBuy(item.id);
          },
          child: Text("Buy"),
        ),
      ),
    );
  }
}
