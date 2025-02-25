import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //curretn user
  User? currentUser() {
    return _auth.currentUser;
  }

  //sign in
  Future<UserCredential?> signInWithEmailPassword(String email, password) async {
  try {
    // Check if a user is already signed in and return early
    if (_auth.currentUser != null) {
      print("User already signed in.");
      return _auth.currentUser as UserCredential?;
    }

    // Sign in user
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email, password: password,
    );

    // Force token refresh to avoid stale token issues
    await userCredential.user?.getIdToken(true);

    // Check if user already exists in Firestore
    DocumentSnapshot userDoc = await _firestore.collection("Users").doc(userCredential.user!.uid).get();
    if (!userDoc.exists) {
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      print("User info saved in Firestore.");
    }

    return userCredential;
  } on FirebaseAuthException catch (e) {
    print("Firebase Auth Error: ${e.code}");
    throw Exception(e.code);
  }
}

  //sign up
  Future<UserCredential> signUpWithEmailPassword(String email, String password, String role) async {
  try {
    // Check if user already exists to avoid duplicate sign-ups
    final existingUser = await _firestore.collection("Users")
      .where('email', isEqualTo: email)
      .get();

    if (existingUser.docs.isNotEmpty) {
      throw Exception("User already exists. Try logging in.");
    }

    // Create user in Firebase Auth
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email, password: password,
    );

    // Save user information to Firestore
    await _firestore.collection("Users").doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email,
      'role': role,
    });

    print("User registered successfully.");
    return userCredential;
  } on FirebaseAuthException catch (e) {
    throw Exception(e.code);
  }
}

  //sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //errors
}
