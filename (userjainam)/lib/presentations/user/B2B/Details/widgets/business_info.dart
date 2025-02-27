import 'package:flutter/material.dart';
import 'ui_helpers.dart';

class BusinessInfoSection extends StatelessWidget {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final String businessType = "Manufacturing";

  @override
  Widget build(BuildContext context) {
    return buildCenteredCard(
      context,
      title: "Business Information",
      children: [
        buildInputField(companyNameController, "Company Name", Icons.business),
        buildInputField(gstController, "GST Number (Optional)", Icons.confirmation_number),
        buildDropdownField(
          label: "Business Type",
          value: businessType,
          items: ["Manufacturing", "Retail", "Service"],
          icon: Icons.category,
          onChanged: (val) {},
        ),
      ],
    );
  }
}
