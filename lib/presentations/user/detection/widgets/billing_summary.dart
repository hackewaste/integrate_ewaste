import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/selected_items_provider.dart';

class BillingSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedItemsProvider = Provider.of<SelectedItemsProvider>(context);
    var selectedItems = selectedItemsProvider.selectedItems;

    return Scaffold(
      appBar: AppBar(title: Text("Billing Summary")),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Total Credits",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
              Text(
                "${selectedItemsProvider.getTotalCredits()}",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 10),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: selectedItems.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Smooth rounded corners
                        child: Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent, // Hides the default divider
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              collapsedBackgroundColor: Colors.blueGrey.shade50, // Light background
                              backgroundColor: Colors.white,
                              title: Center(
                                child: Text(
                                  entry.key,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              children: entry.value.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  child: ListTile(
                                    tileColor: Colors.blueGrey.shade50,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    title: Text(
                                      "${item.name} x ${item.count}",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    trailing: Text(
                                      "${item.baseCredit * item.count} credits",
                                      style: TextStyle(fontSize: 16, color: Colors.green),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          // Floating Total Credit Badge
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.25,
            right: MediaQuery.of(context).size.width * 0.25,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: Center(
                child: Text(
                  "Total: ${selectedItemsProvider.getTotalCredits()} Credits",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}