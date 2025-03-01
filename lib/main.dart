
import 'package:ewaste/data/services/detection_billing_services.dart';
import 'package:ewaste/pages/profilepages/UserAccountPage1.dart';
import 'package:ewaste/presentations/volunteer/home/VolunteerHome.dart';
import 'package:ewaste/pages/dropimageai(working).dart';
import 'package:ewaste/pages/info.dart';
import 'package:ewaste/pages/login.dart';
import 'package:ewaste/pages/struserhome.dart';
import 'package:ewaste/pages/onboarding1.dart';

import 'package:ewaste/presentations/user/DisposalLocation/disposal_locations_page.dart';
import 'package:ewaste/presentations/user/detection/detection_page.dart';
import 'package:ewaste/presentations/user/home/userHomePage.dart';
import 'package:ewaste/presentations/user/B2B/screens/Order_Summary.dart';
import 'package:ewaste/presentations/user/B2B/screens/bulk_scrap_request.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/models/selected_items_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure everything is loaded before runApp
  await Firebase.initializeApp();
  // Initialize Firebase

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedItemsProvider()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoElectronic',
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, 
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Test B2B Post Section")),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: OnboardingScreen(), // Call your widget here
//         ),
//       ),
//     );
//   }
// }