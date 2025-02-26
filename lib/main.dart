



import 'package:ewaste/pages/dropImage.dart';
import 'package:ewaste/pages/info.dart';
import 'package:ewaste/pages/struserhome.dart';
import 'package:ewaste/presentations/user/B2B/Details/enter_details_page.dart';
import 'package:ewaste/presentations/user/uploadWaste/widgets/detection_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure everything is loaded before runApp
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoElectronic',
      debugShowCheckedModeBanner: false,
      home: DetectionPage1(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}