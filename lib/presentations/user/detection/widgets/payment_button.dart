import 'package:ewaste/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ewaste/data/models/selected_items_provider.dart';


import '../../../../data/models/ewaste_item.dart';
import '../../../../data/services/request_service.dart';
import '../pickup_request_status_page.dart';

class PaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var selectedItemsProvider = Provider.of<SelectedItemsProvider>(context, listen: false);
        var authService = AuthService();
        var currentUser = authService.currentUser();

        // Convert selected items to eWasteItems format
        List<Map<String, dynamic>> eWasteItems = selectedItemsProvider.selectedItems.entries.expand((categoryEntry) {
          String category = categoryEntry.key;
          List<EWasteItem> items = categoryEntry.value;

          return items.map((item) {
            return {
              "name": item.name,
              "category": category,
              "credits": item.baseCredit * item.count,
            };
          });
        }).toList();

        int totalCredits = selectedItemsProvider.getTotalCredits();
         String userId = currentUser!.uid;

        String? requestId = await RequestService().createRequest(
          userId: userId,
          eWasteItems: eWasteItems,
          totalCredits: totalCredits,
        );

        if (requestId != null) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Request Created! ID: $requestId")),
          );

          // Navigate to PickupRequestStatusPage with the requestId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PickupRequestStatusPage(requestId: requestId),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to create request")),
          );
        }
      },
      child: const Text("Confirm & Proceed"),
    );
  }
}
