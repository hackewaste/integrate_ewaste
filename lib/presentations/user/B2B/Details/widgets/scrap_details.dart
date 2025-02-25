import 'package:flutter/material.dart';

class ScrapDetailsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Scrap Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              DropdownButtonFormField(
                items: ["Metal", "Plastic", "Electronic"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {},
                decoration: InputDecoration(labelText: "Type of Scrap"),
              ),
              TextField(decoration: InputDecoration(labelText: "Scrap Description")),
              TextField(decoration: InputDecoration(labelText: "Quantity (KG or Tonnes)")),
            ],
          ),
        ),
      ),
    );
  }
}
