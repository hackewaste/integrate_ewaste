import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewaste/firebase_options.dart';
import 'package:ewaste/pages/UserHomePage.dart';
import 'package:ewaste/pages/VolunteerHomePage.dart';
import 'package:ewaste/pages/dropImage.dart';
import 'package:ewaste/pages/login.dart';
import 'package:ewaste/pages/register.dart';
import 'package:ewaste/services/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Manually configure Firebase options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Ewaste());
}

class Ewaste extends StatelessWidget {
  const Ewaste({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}
 