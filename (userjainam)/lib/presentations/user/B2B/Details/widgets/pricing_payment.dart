import 'package:flutter/material.dart';
import 'ui_helpers.dart';

class PricingPaymentSection extends StatelessWidget {
  final TextEditingController priceController = TextEditingController();
  bool negotiationAllowed = true;
  final String paymentMode = "UPI";

  @override
  Widget build(BuildContext context) {
    return buildCenteredCard(
      context,
      title: "Pricing & Payment",
      children: [
        buildInputField(priceController, "Expected Price", Icons.price_check),
        buildSwitchField("Negotiation Allowed", negotiationAllowed, (val) {}),
        buildDropdownField(
          label: "Payment Mode",
          value: paymentMode,
          items: ["UPI", "Bank Transfer", "Cash"],
          icon: Icons.payment,
          onChanged: (val) {},
        ),
      ],
    );
  }
}
