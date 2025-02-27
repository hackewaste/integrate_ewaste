import 'package:ewaste/presentations/user/DYK/widgets/video_card.dart';
import 'package:ewaste/presentations/user/DYK/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:ewaste/data/recycling_steps.dart';


class RecyclingStepsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recycling Process",
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.teal[100],
        ),
        child:Column(
          children: [
            SizedBox(height: 20), //
            VideoCard(), // Using the modular VideoCard widget
            SizedBox(height: 20), // Space between video card and steps

            Expanded(
              child: ListView.builder(
                itemCount: recyclingSteps.length,
                itemBuilder: (context, index) {
                  return RecyclingStepCard(step: recyclingSteps[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
