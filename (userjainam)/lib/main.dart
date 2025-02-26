import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewaste/firebase_options.dart';
import 'package:ewaste/pages/VolunteerHomePage.dart';
import 'package:ewaste/pages/dropImage.dart';
import 'package:ewaste/pages/login.dart';
import 'package:ewaste/services/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ewaste/presentations/user/home/userHomePage.dart';
import 'package:ewaste/pages/onboarding1.dart';
import 'package:ewaste/pages/onboarding2.dart';
import 'package:ewaste/pages/onboarding3.dart';
import 'package:ewaste/pages/volunteerpages/theme_provider.dart';
import 'package:provider/provider.dart'; // Ensure provider package is imported
import 'package:ewaste/pages/redeem.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Manually configure Firebase options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(UserEwaste());
}

class UserEwaste extends StatelessWidget {
   const UserEwaste({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Register ThemeProvider
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return GamificationScreen(); //If logged in, go to homepage
            //return RewardsScreen();

          } else {
            return Login(); // Otherwise, go to login
          }
          },
        ),
      ),
    );
  }
}
 