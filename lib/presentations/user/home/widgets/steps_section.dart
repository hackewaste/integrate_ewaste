import 'package:flutter/material.dart';

Widget StepsSection() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 255, 249, 231),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      border: Border.all(
        color: Colors.amber[200]!,
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        StepBox(
          number: "1",
          imagePath: 'assets/man.png',
          label: 'Pickup',
          description: 'Schedule pickup',
        ),
        StepConnector(),
        StepBox(
          number: "2",
          imagePath: 'assets/priority-list.png',
          label: 'Category',
          description: 'Classify items',
        ),
        StepConnector(),
        StepBox(
          number: "3",
          imagePath: 'assets/submit.png',
          label: 'Submit',
          description: 'Track request',
        ),
      ],
    ),
  );
}

class StepBox extends StatelessWidget {
  final String imagePath;
  final String label;
  final String number;
  final String description;

  const StepBox({
    super.key,
    required this.imagePath,
    required this.label,
    required this.number,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
            color: Colors.amber[400],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Colors.amber[100]!,
              width: 1.0,
            ),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class StepConnector extends StatelessWidget {
  const StepConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Divider(
        thickness: 2,
        color: Colors.amber[400],
      ),
    );
  }
}