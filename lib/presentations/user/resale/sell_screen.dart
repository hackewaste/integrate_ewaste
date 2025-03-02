import 'package:ewaste/data/services/resale_service.dart';
import 'package:flutter/material.dart';


class SellScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final String sellerId = "user123"; // Replace with the actual user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sell Item')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Item Name')),
            TextField(controller: priceController, decoration: InputDecoration(labelText: 'Approx Price'), keyboardType: TextInputType.number),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               ResaleService().addResaleItem(nameController.text, int.parse(priceController.text), sellerId);
                Navigator.pop(context);
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
