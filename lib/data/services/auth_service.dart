import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? currentUser() {
    return _auth.currentUser;
  }

  // Sign in
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign up with role-based data storage
  Future<UserCredential> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
    required String role,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      String uid = userCredential.user!.uid;
      Map<String, dynamic> userData = {
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'createdAt': Timestamp.now(),
      };

      if (role == 'User') {
        userData.addAll({
          'address': address,
          'credits': 0,
          'totalRequests': 0,
          'completedRequests': 0,
          'pendingRequests': [],
        });
        await _firestore.collection("Users").doc(uid).set(userData);
      } else if (role == 'Volunteer') {
        userData.addAll({
          'totalDeliveries': 0,
          'completedDeliveries': 0,
          'pendingDeliveries': [],
          'currentRequestId': null,
          'status': 'off-duty',
          'location': {'latitude': 0.0, 'longitude': 0.0},
        });
        await _firestore.collection("Volunteers").doc(uid).set(userData);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
