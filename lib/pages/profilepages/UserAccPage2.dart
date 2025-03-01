import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ewaste/data/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const UserAccountPage2(), // No need to pass static UID
    );
  }
}

class UserAccountPage2 extends StatefulWidget {
  const UserAccountPage2({Key? key}) : super(key: key);

  @override
  _UserAccountPage2State createState() => _UserAccountPage2State();
}

class _UserAccountPage2State extends State<UserAccountPage2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // Controllers to hold user data
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  bool isLoading = true;
  String? uid; // Store user's UID dynamically

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data using dynamic UID
  Future<void> _fetchUserData() async {
    try {
      final user = _authService.currentUser();
      if (user == null) {
        print("No user logged in.");
        return;
      }

      setState(() => uid = user.uid); // Store the UID

      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        _fullNameController.text = data['fullName'] ?? '';
        _emailController.text = data['email'] ?? '';
        _phoneNumberController.text = data['phoneNumber'] ?? '';
        _cityController.text = data['city'] ?? '';
        _stateController.text = data['state'] ?? '';
        _postalCodeController.text = data['postalCode'] ?? '';
        _countryController.text = data['country'] ?? '';
        _skillsController.text = data['skills'] ?? '';
      }
    } catch (e) {
      print("Error loading user data: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Save updated user data to Firestore
  Future<void> _saveUserData() async {
    if (uid == null) return; // Avoid saving if UID is missing

    try {
      await _firestore.collection('Users').doc(uid).set({
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'phoneNumber': _phoneNumberController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'postalCode': _postalCodeController.text,
        'country': _countryController.text,
        'skills': _skillsController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Volunteer Account Information',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/volunteer.png'),
                    ),
                    const SizedBox(height: 8.0),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile Picture'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Editable Fields
              _buildEditableField('Full Name', _fullNameController),
              _buildEditableField('Email Address', _emailController),
              _buildEditableField('Phone Number', _phoneNumberController),
              _buildEditableField('City', _cityController),
              _buildEditableField('State', _stateController),
              _buildEditableField('Postal Code', _postalCodeController),
              _buildEditableField('Country', _countryController),
              _buildEditableField('Skills', _skillsController),

              const SizedBox(height: 24.0),

              // Save & Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _saveUserData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                    ),
                    child: const Text('Save'),
                  ),
                  const SizedBox(width: 16.0),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to create editable fields
  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    _skillsController.dispose();
    super.dispose();
  }
}
