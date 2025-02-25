import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewaste/firebase_options.dart';
import 'package:ewaste/pages/OrderSummaryPage.dart';
import 'package:ewaste/pages/RequestConfirmationPage.dart';
import 'package:ewaste/pages/RequestTrackingPage.dart';
import 'package:ewaste/pages/UserHomePage.dart';
import 'package:ewaste/pages/VolunteerHomePage.dart';
import 'package:ewaste/pages/VolunteerRequestPage.dart';
import 'package:ewaste/pages/dropImage.dart';
import 'package:ewaste/pages/login.dart';
import 'package:ewaste/pages/register.dart';
import 'package:ewaste/presentations/user/B2B/Confirmation/b2b_req_confirmation.dart';
import 'package:ewaste/presentations/user/B2B/Details/enter_details_page.dart';
import 'package:ewaste/presentations/user/DisposalLocation/disposal_locations_page.dart';
import 'package:ewaste/presentations/user/home/widgets/didyouknow.dart';
//import 'package:ewaste/services/auth_gate.dart';
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
      home: EnterDetailsPage(),
    );
  }
}
 