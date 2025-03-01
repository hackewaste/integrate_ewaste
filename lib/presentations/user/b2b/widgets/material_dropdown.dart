import 'package:flutter/material.dart';

class MaterialDropdown extends StatelessWidget {
  final String? selectedMaterial;
  final Function(String?) onChanged;

  const MaterialDropdown({super.key, required this.selectedMaterial, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedMaterial,
        items: ['Metal', 'Plastic', 'E-waste', 'Paper'].map((material) {
          return DropdownMenuItem(value: material, child: Text(material));
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Select Material',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
