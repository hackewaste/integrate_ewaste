import 'package:flutter/material.dart';
import '../../../../data/models/recycling_steps.dart';
import 'recycling_steps_timeline.dart';
import 'computer_waste_recycling_process.dart';

class RecyclingDashboard extends StatelessWidget {
  RecyclingDashboard({Key? key}) : super(key: key);

  // Sample recycling steps data
  final List<RecyclingStep> recyclingSteps = [
    RecyclingStep(
      stepNumber: "1",
      title: "Collection",
      description: "Gather all electronic waste from designated collection points or drop-off centers.",
    ),
    RecyclingStep(
      stepNumber: "2",
      title: "Sorting",
      description: "Separate different types of electronic components based on material composition.",
    ),
    RecyclingStep(
      stepNumber: "3",
      title: "Dismantling",
      description: "Carefully disassemble devices to separate reusable components from waste materials.",
    ),
    RecyclingStep(
      stepNumber: "4",
      title: "Material Processing",
      description: "Process different materials through specialized recycling techniques.",
    ),
    RecyclingStep(
      stepNumber: "5",
      title: "Manufacturing",
      description: "Use recycled materials to create new products, completing the recycling loop.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recycling Guide"),
        backgroundColor: Colors.green.shade700,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade700, Colors.green.shade500],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Electronic Waste Recycling",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Learn how to properly recycle electronic waste and understand the transformation process.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.eco, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Help save our planet",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16),

            // Recycling steps timeline
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: RecyclingStepsTimeline(steps: recyclingSteps),
            ),

            SizedBox(height: 16),

            // Divider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Divider(thickness: 1, color: Colors.grey.shade400),
            ),

            SizedBox(height: 16),

            // Computer waste recycling process
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ComputerWasteRecyclingProcess(),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
