// import 'package:ewaste/presentations/user/home/widgets/didyouknow.dart';
// import 'package:ewaste/presentations/volunteer/bottom_navbar_volunteer.dart';
// import 'package:ewaste/presentations/volunteer/appbar_volunteer.dart';
// import 'package:flutter/material.dart';
// // import 'NotificationPage.dart';
// // import 'VolunteerAccPage.dart';



// class VolunteerHomePage extends StatefulWidget {
//   const VolunteerHomePage({super.key});

//   @override
//   State<VolunteerHomePage> createState() => _VolunteerHomePage();
// }

// class _VolunteerHomePage extends State<VolunteerHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppbarVolunteer(),
//       drawer: const Drawer(),
//       body: SingleChildScrollView(

//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Welcome Banner
//               Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.teal[100],
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome, Volunteer!',
//                       style: Theme.of(context)
//                           .textTheme
//                           .headlineSmall
//                           ?.copyWith(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8.0),
//                     Text(
//                       'Your efforts are making a difference. Let’s see what’s on the agenda today.',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 12.0),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.teal,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16.0,
//                           vertical: 8.0,
//                         ),
//                       ),
//                       child: const Text('Start Tasks'),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24.0),
//               RecyclingProcessCard(),

//               // Announcements Section
//               SectionHeader(title: 'Announcements'),
//               const SizedBox(height: 8.0),
//               Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[50],
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       '🌟 Big Cleanup Drive This Weekend!',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     Text(
//                       'Join us this Saturday for a massive cleanup across the city. Your contribution is invaluable. Don’t miss it!',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 12.0),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                       ),
//                       child: const Text('Learn More'),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24.0),

//               // Assigned Tasks Section
//               SectionHeader(title: 'Assigned Tasks', actionText: 'View All'),
//               const SizedBox(height: 16.0),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return TaskCard(
//                     taskNumber: index + 1,
//                     taskDetails: 'Details for Task #${index + 1}',
//                   );
//                 },
//               ),
//               const SizedBox(height: 24.0),

//               // Progress Tracker
//               SectionHeader(title: 'Your Progress'),
//               const SizedBox(height: 16.0),
//               GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16.0,
//                 mainAxisSpacing: 16.0,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: const [
//                   StatBox(label: 'Tasks Completed', value: '12'),
//                   StatBox(label: 'Hours Volunteered', value: '24'),
//                   StatBox(label: 'Items Collected', value: '350'),
//                   StatBox(label: 'Pending Tasks', value: '3'),
//                 ],
//               ),
//               const SizedBox(height: 24.0),

//               // Leaderboard Section
//               SectionHeader(title: 'Volunteer Leaderboard'),
//               const SizedBox(height: 8.0),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return LeaderboardCard(
//                     rank: index + 1,
//                     volunteerName: 'Volunteer ${index + 1}',
//                     completedTasks: 30 - index * 5,
//                   );
//                 },
//               ),
//               const SizedBox(height: 24.0),

//               // Steps to Help Section
//               SectionHeader(title: 'Steps to Volunteer'),
//               const SizedBox(height: 16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: const [
//                   StepBox(
//                     imagePath: 'assets/task.png',
//                     label: 'View Tasks',
//                   ),
//                   StepBox(
//                     imagePath: 'assets/pickup.png',
//                     label: 'Pickup Items',
//                   ),
//                   StepBox(
//                     imagePath: 'assets/report.png',
//                     label: 'Submit Reports',
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24.0),

//               // Feedback Section
//               SectionHeader(title: 'Feedback'),
//               const SizedBox(height: 8.0),
//               Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.pink[50],
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Have suggestions for improvement?',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8.0),
//                     TextField(
//                       maxLines: 3,
//                       decoration: InputDecoration(
//                         hintText: 'Write your feedback here...',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink,
//                       ),
//                       child: const Text('Submit Feedback'),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24.0),

//               // Invite Section
//               Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.purple[50],
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       '🎉 Invite Friends to Join!',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     const Text(
//                       'Share the joy of volunteering. Invite friends to join and earn rewards!',
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 12.0),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.purple,
//                       ),
//                       child: const Text('Invite Now'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: VolunteerBottomNavigation(),
//     );
//   }
// }


// // Reusable Section Header Widget
// class SectionHeader extends StatelessWidget {
//   final String title;
//   final String? actionText;

//   const SectionHeader({
//     super.key,
//     required this.title,
//     this.actionText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         if (actionText != null)
//           TextButton(
//             onPressed: () {},
//             child: Text(actionText!),
//           ),
//       ],
//     );
//   }
// }

// // Reusable Task Card Widget
// class TaskCard extends StatelessWidget {
//   final int taskNumber;
//   final String taskDetails;

//   const TaskCard({
//     super.key,
//     required this.taskNumber,
//     required this.taskDetails,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16.0),
//       elevation: 2.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: ListTile(
//         leading: const Icon(Icons.task, color: Colors.teal),
//         title: Text('Task #$taskNumber'),
//         subtitle: Text(taskDetails),
//         trailing: ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[300]),
//           child: const Text('Details'),
//         ),
//       ),
//     );
//   }
// }

// // Reusable Leaderboard Card Widget
// class LeaderboardCard extends StatelessWidget {
//   final int rank;
//   final String volunteerName;
//   final int completedTasks;

//   const LeaderboardCard({
//     super.key,
//     required this.rank,
//     required this.volunteerName,
//     required this.completedTasks,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12.0),
//       elevation: 2.0,
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.teal,
//           child: Text('#$rank', style: const TextStyle(color: Colors.white)),
//         ),
//         title: Text(volunteerName),
//         subtitle: Text('Tasks Completed: $completedTasks'),
//         trailing: const Icon(Icons.star, color: Colors.amber),
//       ),
//     );
//   }
// }

// // Reusable Stat Box Widget
// class StatBox extends StatelessWidget {
//   final String label;
//   final String value;

//   const StatBox({
//     super.key,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.teal[50],
//         borderRadius: BorderRadius.circular(12.0),
//         border: Border.all(color: Colors.teal, width: 1),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.teal,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Reusable Step Box Widget
// class StepBox extends StatelessWidget {
//   final String imagePath;
//   final String label;

//   const StepBox({
//     super.key,
//     required this.imagePath,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Image.asset(
//           imagePath,
//           height: 50.0,
//           width: 50.0,
//           fit: BoxFit.cover,
//         ),
//         const SizedBox(height: 8.0),
//         Text(label, textAlign: TextAlign.center),
//       ],
//     );
//   }
// }

// //************************ */
// class ExplorePage extends StatelessWidget {
//   const ExplorePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Explore')),
//       body: const Center(
//         child: Text('Explore Page Content'),
//       ),
//     );
//   }
// }

// class SavedPage extends StatelessWidget {
//   const SavedPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Saved')),
//       body: const Center(
//         child: Text('Saved Page Content'),
//       ),
//     );
//   }
// }

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: const Center(
//         child: Text('Profile Page Content'),
//       ),
//     );
//   }
// }