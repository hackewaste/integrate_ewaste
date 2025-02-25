import 'package:flutter/material.dart';

class BusinessInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Business Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: "Company Name")),
              TextField(decoration: InputDecoration(labelText: "GST Number (Optional)")),
              DropdownButtonFormField(
                items: ["Manufacturing", "IT", "Retail"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {},
                decoration: InputDecoration(labelText: "Business Type"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
