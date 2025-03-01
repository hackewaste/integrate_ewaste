import 'package:flutter/material.dart';

class RecyclerFormPage extends StatefulWidget {
  const RecyclerFormPage({Key? key}) : super(key: key);

  @override
  _RecyclerFormPageState createState() => _RecyclerFormPageState();
}

class _RecyclerFormPageState extends State<RecyclerFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController servicesController = TextEditingController();
  final TextEditingController volunteersController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  List<String> serviceOptions = [
    "E-Waste",
    "Plastics",
    "Paper",
    "Metal",
    "Glass",
    "Batteries",
    "Organic Waste",
    "Textiles",
    "Chemicals",
    "Construction Debris"
  ];

  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text(
          "Recycler Registration",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle("Organization Details"),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: _inputDecoration(
                    "Recycler/Organization Name",
                    Icons.business,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter organization name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: locationController,
                  decoration: _inputDecoration(
                    "Location/Service Area",
                    Icons.location_on,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter location";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildSectionTitle("Contact Information"),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: _inputDecoration(
                    "Email Address",
                    Icons.email,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email address";
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: _inputDecoration(
                    "Contact Number",
                    Icons.phone,
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter contact number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildSectionTitle("Services Information"),
                const SizedBox(height: 16),
                const Text(
                  "Select Services Offered:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: serviceOptions.map((service) {
                    final isSelected = selectedServices.contains(service);
                    return FilterChip(
                      label: Text(service),
                      selected: isSelected,
                      selectedColor: Colors.green[100],
                      backgroundColor: Colors.grey[300],
                      checkmarkColor: Colors.green,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedServices.add(service);
                          } else {
                            selectedServices.remove(service);
                          }
                          servicesController.text = selectedServices.join(", ");
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Submit Collaboration Request",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 60,
          height: 3,
          color: Colors.lightGreen,
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.green),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newRecycler = {
        "name": nameController.text,
        "location": locationController.text,
        "services": selectedServices.join(", "),
      };
      Navigator.pop(context, newRecycler);
    }
  }
}
