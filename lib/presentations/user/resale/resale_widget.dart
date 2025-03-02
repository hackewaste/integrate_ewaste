import 'package:ewaste/presentations/user/resale/sell_screen.dart';
import 'package:flutter/material.dart';

import 'buy_screen.dart';


class ResaleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Resale", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.shopping_cart),
                  label: Text("Buy"),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => BuyScreen())),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.sell),
                  label: Text("Sell"),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SellScreen())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
