import 'package:flutter/material.dart';

class RecyclingProcess {
  final String title;
  final String description;
  final IconData icon;
  final String inputMaterial;
  final String outputMaterial;
  final Color primaryColor;
  final String environmentalImpact;

  RecyclingProcess({
    required this.title,
    required this.description,
    required this.icon,
    required this.inputMaterial,
    required this.outputMaterial,
    required this.primaryColor,
    required this.environmentalImpact,
  });
}

class ComputerWasteRecyclingProcess extends StatelessWidget {
  ComputerWasteRecyclingProcess({Key? key}) : super(key: key);

  final List<RecyclingProcess> processes = [
    RecyclingProcess(
      title: "Circuit Boards",
      description: "Circuit boards are processed to extract precious metals like gold, silver, and copper.",
      icon: Icons.memory,
      inputMaterial: "Old Circuit Boards",
      outputMaterial: "Precious Metals",
      primaryColor: Colors.amber.shade700,
      environmentalImpact: "Prevents toxic metals from reaching landfills and saves mining resources.",
    ),
    RecyclingProcess(
      title: "Plastic Casings",
      description: "Plastic components are shredded, melted, and transformed into new plastic products.",
      icon: Icons.cases,
      inputMaterial: "Computer Casings",
      outputMaterial: "Recycled Plastic Products",
      primaryColor: Colors.blue.shade700,
      environmentalImpact: "Reduces petroleum consumption and plastic waste in oceans.",
    ),
    RecyclingProcess(
      title: "Metal Components",
      description: "Aluminum, steel, and other metals are melted down and reused in manufacturing.",
      icon: Icons.view_in_ar,
      inputMaterial: "Metal Parts",
      outputMaterial: "New Metal Products",
      primaryColor: Colors.grey.shade700,
      environmentalImpact: "Saves 95% of energy compared to mining new metal.",
    ),
    RecyclingProcess(
      title: "Glass Screens",
      description: "Monitor glass is crushed and used in construction materials or new glass products.",
      icon: Icons.monitor,
      inputMaterial: "Monitor Screens",
      outputMaterial: "Construction Materials",
      primaryColor: Colors.teal.shade700,
      environmentalImpact: "Reduces landfill waste and saves sand extraction.",
    ),
    RecyclingProcess(
      title: "Batteries",
      description: "Lithium and other materials are extracted from batteries for reuse in new batteries.",
      icon: Icons.battery_full,
      inputMaterial: "Old Batteries",
      outputMaterial: "New Battery Materials",
      primaryColor: Colors.green.shade700,
      environmentalImpact: "Prevents toxic chemicals from contaminating groundwater.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              "Transform Tech Waste into Treasure",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              "Discover how your old computer parts become valuable resources",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.eco,
                    color: Colors.green.shade700,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Every recycled computer saves enough energy to power a home for 6 months",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 420,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: processes.length,
              itemBuilder: (context, index) {
                return RecyclingProcessCard(process: processes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecyclingProcessCard extends StatelessWidget {
  final RecyclingProcess process;

  const RecyclingProcessCard({Key? key, required this.process}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        elevation: 6,
        shadowColor: process.primaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    process.primaryColor,
                    process.primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      process.icon,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      process.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Process description
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                process.description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
            ),
            // Transformation visualization
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    "TRANSFORMATION PROCESS",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Input material
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "INPUT",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                process.inputMaterial,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow and recycling process
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 2,
                          height: 50,
                          color: process.primaryColor.withOpacity(0.5),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: process.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: process.primaryColor.withOpacity(0.5),
                            ),
                          ),
                          child: Icon(
                            Icons.autorenew,
                            color: process.primaryColor,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Output material
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: process.primaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: process.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.eco,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "OUTPUT",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: process.primaryColor.withOpacity(0.7),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                process.outputMaterial,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: process.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Environmental impact
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.public,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      process.environmentalImpact,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}