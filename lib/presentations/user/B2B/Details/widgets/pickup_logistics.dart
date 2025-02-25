import 'package:flutter/material.dart';

class PickupLogisticsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Pickup & Logistics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: "Pickup Address")),
              TextField(decoration: InputDecoration(labelText: "Pickup Date & Time")),
              SwitchListTile(
                title: Text("Loading Assistance Required?"),
                value: false,
                onChanged: (bool val) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
