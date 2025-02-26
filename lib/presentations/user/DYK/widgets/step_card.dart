import 'package:flutter/material.dart';

import '../../../../data/models/recycling_steps.dart';


class RecyclingStepCard extends StatelessWidget {
  final RecyclingStep step;

  const RecyclingStepCard({Key? key, required this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Card
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 24),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            shadowColor: Colors.black26,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,

                  ),
                  SizedBox(height: 6),
                  Text(
                    step.description,

                  ),
                ],
              ),
            ),
          ),
        ),
        // Step Circle
        Positioned(
          left: 0,
          top: 16,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent[100],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                step.stepNumber,

              ),
            ),
          ),
        ),
      ],
    );
  }
}
