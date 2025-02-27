import 'package:flutter/material.dart';
import 'ui_helpers.dart';

class ScrapDetailsSection extends StatelessWidget {
  final String scrapType = "Electronic";
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildCenteredCard(
      context,
      title: "Scrap Details",
      children: [
        buildDropdownField(
          label: "Type of Scrap",
          value: scrapType,
          items: ["Metal", "Plastic", "Electronic"],
          icon: Icons.recycling,
          onChanged: (val) {},
        ),
        buildInputField(descriptionController, "Description", Icons.description),
        buildInputField(quantityController, "Quantity (KG/Tonnes)", Icons.scale),
      ],
    );
  }
}
