

  // Keep only one correct import
  import 'package:flutter/material.dart';
  import '../screens/order_summary.dart';
  // Local Imports
import '../screens/order_summary.dart';
import '../widgets/material_dropdown.dart';

import '../widgets/material_dropdown.dart';
  import 'package:firebase_auth/firebase_auth.dart';

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_core/firebase_core.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const BulkScrapRequestPage(),
    );
  }
}

class BulkScrapRequestPage extends StatefulWidget {
  const BulkScrapRequestPage({super.key});

  @override
  State<BulkScrapRequestPage> createState() => _BulkScrapRequestPageState();
}

class _BulkScrapRequestPageState extends State<BulkScrapRequestPage> {
  final organizationController = TextEditingController();
  final businessNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final addressController = TextEditingController();

  final noteController = TextEditingController();
  bool isSpecialRequest = false;
  String? selectedMaterial;
  int? selectedQuantity;

  final List<String> materials = ['Metal', 'Plastic', 'E-waste', 'Paper'];
  final List<int> quantities = [100, 200, 300, 400, 500];

  Future<void> submitRequest(BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please log in to submit a request")),
    );
    return;
  }

  try {
    // Create Firestore entry
    DocumentReference docRef = await FirebaseFirestore.instance.collection('bulk_scrap_requests').add({
      'userId': user.uid,
      'businessName': businessNameController.text.trim(),
      'organizationName': organizationController.text.trim(),
      'contactNumber': contactNumberController.text.trim(),
      'selectedMaterial': selectedMaterial,
      'selectedQuantity': selectedQuantity,
      'note': noteController.text.trim(),
      'isSpecialRequest': isSpecialRequest,
      'status': 'Pending',  // Default status
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Request submitted successfully!")),
    );

    // Navigate to Order Summary Page with submitted data
 Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => OrderSummaryPage(
      businessName: businessNameController.text.trim(),
      organizationName: organizationController.text.trim(),
      contactNumber: contactNumberController.text.trim(),
      selectedMaterial: selectedMaterial!,
      selectedQuantity: selectedQuantity!,
      address: addressController.text.trim(), // ✅ Ensure address is provided
      isSpecialRequest: isSpecialRequest,
    ),
  ),
);




  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Bulk Scrap Request',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              _buildTextField(businessNameController, 'Business Name'),
              _buildTextField(organizationController, 'Organisation Name (Optional)'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButtonFormField<String>(
                  value: selectedMaterial,
                  items: materials.map((material) {
                    return DropdownMenuItem(
                      value: material,
                      child: Text(material),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => selectedMaterial = value),
                  decoration: InputDecoration(
                    hintText: 'Select Material',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 10,
                  children: quantities.map((qty) {
                    return ChoiceChip(
                      label: Text('$qty kg'),
                      selected: selectedQuantity == qty,
                      onSelected: (selected) => setState(() => selectedQuantity = qty),
                    );
                  }).toList(),
                ),
              ),
              _buildTextField(contactNumberController, 'Contact Number'),
              _buildTextField(noteController, 'Add a note or description (Optional)', maxLines: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: isSpecialRequest,
                      onChanged: (value) => setState(() => isSpecialRequest = value!),
                    ),
                    const Text('Special Request')
                  ],
                ),
              ),
              _buildTextField(addressController, 'Enter Address'),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => submitRequest(context),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 149, 208, 230),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Submit Details', style: TextStyle(fontSize: 18, color: Colors.black87)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(TextEditingController controller, String hintText, {int maxLines = 1}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
