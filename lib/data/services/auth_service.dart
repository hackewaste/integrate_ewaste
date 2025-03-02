import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? currentUser() {
    return _auth.currentUser;
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? address, // ✅ Optional address for users
    required String role,
  }) async {
    try {
      // Create user with email & password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user == null) throw Exception("User registration failed. Please try again.");

      String uid = user.uid;
      String normalizedRole = role.trim().toLowerCase(); // ✅ Ensure consistent role names

      // Construct user data based on role
      Map<String, dynamic> userData = {
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'role': normalizedRole,
        'createdAt': Timestamp.now(),
      };

      if (normalizedRole == 'user') {
        userData.addAll({
          'address': address ?? "", // ✅ Handle optional address
          'credits': 0,
          'totalRequests': 0,
          'completedRequests': 0,
          'pendingRequests': [],
        });
      } else if (normalizedRole == 'volunteer') {
        userData.addAll({
          'totalDeliveries': 0,
          'completedDeliveries': 0,
          'pendingDeliveries': [],
          'currentRequestId': null,
          'status': 'off-duty',
          'location': {'latitude': 0.0, 'longitude': 0.0},
        });
      } else {
        throw Exception("Invalid role. Must be 'User' or 'Volunteer'.");
      }

      // Save user data to Firestore
      try {
        await _firestore.collection(_getCollectionName(normalizedRole)).doc(uid).set(userData);
      } catch (e) {
        await user.delete(); // ✅ Cleanup if Firestore write fails
        throw Exception("Failed to save user data. Please try again.");
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "An error occurred during sign-up.");
    }
  }

  // Get Firestore collection name based on role
  String _getCollectionName(String role) {
    return role == 'user' ? "Users" : "Volunteers";
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
      throw Exception("Sign out failed. Please try again.");
    }
  }
}
