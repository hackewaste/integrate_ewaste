// import 'package:ewaste/presentations/user/DYK/widgets/step_card.dart';
// import 'package:ewaste/presentations/user/DYK/widgets/video_card.dart';
// import 'package:flutter/material.dart';
// import '../../../data/models/recycling_steps.dart';

// class RecyclingStepsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Our Environmental Impact",
//         ),
//         backgroundColor: Colors.green.shade700,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.teal[100],
//         ),
//         child: ListView(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           children: [
//             // Company mission statement
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Our Mission",
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                             color: Colors.green.shade800,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     SizedBox(height: 12),
//                     Text(
//                       "We are committed to reducing e-waste through sustainable recycling practices. Our goal is to create a cleaner environment while educating communities about responsible electronics disposal.",
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
            
//             SizedBox(height: 20),
            
//             // Video showcase
//             VideoCard(),
            
//             SizedBox(height: 20),
            
//             // Environmental impact statistics
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Our Environmental Impact",
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                             color: Colors.green.shade800,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     SizedBox(height: 12),
//                     _buildImpactStat(context, "Tonnes of e-waste recycled", "1,250+"),
//                     _buildImpactStat(context, "Harmful materials prevented from landfills", "500kg+"),
//                     _buildImpactStat(context, "Communities engaged", "35+"),
//                     _buildImpactStat(context, "Awareness workshops conducted", "75+"),
//                   ],
//                 ),
//               ),
//             ),
            
//             SizedBox(height: 20),
            
//             // Section title for recycling steps
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8),
//               child: Text(
//                 "Our Recycling Process",
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       color: Colors.green.shade800,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//             ),
            
//             // Recycling steps
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: recyclingSteps.length,
//               itemBuilder: (context, index) {
//                 return RecyclingStepCard(step: recyclingSteps[index]);
//               },
//             ),
            
//             SizedBox(height: 20),
            
//             // Community involvement
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Community Involvement",
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                             color: Colors.green.shade800,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     SizedBox(height: 12),
//                     Text(
//                       "We believe in empowering communities through education. Our team regularly conducts workshops and awareness programs to educate people about e-waste hazards and sustainable practices.",
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     SizedBox(height: 16),
//                     OutlinedButton(
//                       onPressed: () {
//                         // Navigate to community programs page
//                       },
//                       child: Text("Join Our Community Programs"),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: Colors.green.shade800,
//                         side: BorderSide(color: Colors.green.shade800),
//                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget _buildImpactStat(BuildContext context, String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//           Text(
//             value,
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   color: Colors.green.shade700,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class RecyclingStep {
      final String stepNumber;
      final String title;
      final String description;
      final String? imageUrl;

      RecyclingStep({
        required this.stepNumber,
        required this.title,
        required this.description,
        this.imageUrl,
      });
    }
