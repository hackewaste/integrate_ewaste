import 'package:flutter/material.dart';

class PricingPaymentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Pricing & Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: "Expected Price (Optional)")),
              SwitchListTile(
                title: Text("Negotiation Allowed?"),
                value: true,
                onChanged: (bool val) {},
              ),
              DropdownButtonFormField(
                items: ["UPI", "Bank Transfer", "Cash", "Cheque"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {},
                decoration: InputDecoration(labelText: "Payment Mode"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
