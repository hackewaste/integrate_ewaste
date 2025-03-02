import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../data/models/recycling_steps.dart';

class RecyclingStepsTimeline extends StatelessWidget {
  final List<RecyclingStep> steps;

  const RecyclingStepsTimeline({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 24),
            child: Text(
              "Recycling Steps",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              return RecyclingStepTimelineItem(
                step: steps[index],
                isFirst: index == 0,
                isLast: index == steps.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }
}

class RecyclingStepTimelineItem extends StatelessWidget {
  final RecyclingStep step;
  final bool isFirst;
  final bool isLast;

  const RecyclingStepTimelineItem({
    Key? key,
    required this.step,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get icon based on step title or content
    IconData stepIcon = _getIconForStep(step.title);
    Color stepColor = _getColorForStep(step.stepNumber);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line and circle
          Column(
            children: [
              // Top connector line (hidden for first item)
              Container(
                width: 3,
                height: 30,
                color: isFirst ? Colors.transparent : Colors.green.shade300,
              ),
              // Circle with icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: stepColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    stepIcon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              // Bottom connector line (hidden for last item)
              Expanded(
                child: Container(
                  width: 3,
                  color: isLast ? Colors.transparent : Colors.green.shade300,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          // Content
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step number badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: stepColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Step ${step.stepNumber}",
                      style: TextStyle(
                        color: stepColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Card with content
                  Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            step.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 12),
                          // Step image if available
                          if (step.imageUrl != null && step.imageUrl!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                step.imageUrl!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey.shade400,
                                      size: 50,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForStep(String title) {
    final title = step.title.toLowerCase();
    
    if (title.contains('collect') || title.contains('gather')) {
      return Icons.shopping_basket;
    } else if (title.contains('sort') || title.contains('separate')) {
      return Icons.category;
    } else if (title.contains('clean') || title.contains('wash')) {
      return Icons.cleaning_services;
    } else if (title.contains('dismantle') || title.contains('disassemble')) {
      return Icons.build;
    } else if (title.contains('process') || title.contains('convert')) {
      return Icons.loop;
    } else if (title.contains('manufacture') || title.contains('create')) {
      return Icons.precision_manufacturing;
    } else if (title.contains('distribute') || title.contains('deliver')) {
      return Icons.local_shipping;
    } else {
      return Icons.recycling;
    }
  }

  Color _getColorForStep(String stepNumber) {
    // Convert step number to int, defaulting to 1 if not a valid number
    int stepNum = int.tryParse(stepNumber) ?? 1;
    
    // Create a gradient of colors based on step number
    List<Color> stepColors = [
      Colors.green.shade700,
      Colors.teal.shade600,
      Colors.cyan.shade700,
      Colors.blue.shade600,
      Colors.indigo.shade600,
      Colors.deepPurple.shade600,
      Colors.purple.shade600,
    ];
    
    // Use modulo to cycle through colors if there are more steps than colors
    return stepColors[(stepNum - 1) % stepColors.length];
  }
}

