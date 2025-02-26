import 'package:flutter/material.dart';

Widget StepsSection() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.amber[50],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        StepBox(
          imagePath: 'assets/man.png',
          label: 'Get Pickup e-waste',
        ),
        StepBox(
          imagePath: 'assets/priority-list.png',
          label: 'Enter category',
        ),
        StepBox(
          imagePath: 'assets/submit.png',
          label: 'Submit',
        ),
      ],
    ),
  );
}
class StepBox extends StatelessWidget {
  final String imagePath;
  final String label;

  const StepBox({
    super.key,
    required this.imagePath,
    required this.label,
  });
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 50.0,
          width: 50.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8.0),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}