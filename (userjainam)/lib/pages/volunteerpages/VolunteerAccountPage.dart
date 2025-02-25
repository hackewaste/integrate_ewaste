import 'package:flutter/material.dart';
void main() {
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
      home: const VolunteerAccountPage(),
    );
  }
}
class VolunteerAccountPage extends StatelessWidget {
  const VolunteerAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/volunteer.png'), // Replace with the volunteer's image
                    ),
                    const SizedBox(height: 8.0),
                    TextButton.icon(
                      onPressed: () {
                        // Logic to change profile picture
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile Picture'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Personal Information Section
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              _buildEditableField(context, 'Full Name', 'John Doe'),
              const SizedBox(height: 16.0),
              _buildEditableField(context, 'Email Address', 'john.doe@example.com'),
              const SizedBox(height: 16.0),
              _buildEditableField(context, 'Phone Number', '+1234567890'),

              const SizedBox(height: 24.0),
              // Address Section
              const Text(
                'Address Information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              _buildEditableField(context, 'City', 'New York'),
              const SizedBox(height: 16.0),
              _buildEditableField(context, 'State', 'NY'),
              const SizedBox(height: 16.0),
              _buildEditableField(context, 'Postal Code', '10001'),
              const SizedBox(height: 16.0),
              _buildEditableField(context, 'Country', 'United States'),

              const SizedBox(height: 24.0),
              // Skills Section
              const Text(
                'Skills & Expertise',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              _buildEditableField(
                context,
                'Skills',
                'Environmental Awareness, Public Speaking, Waste Management',
              ),

              const SizedBox(height: 24.0),
              // Save & Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Save logic
                    },
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
                    onPressed: () {
                      // Cancel logic
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                    ),
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

  // A helper method for creating editable text fields
  Widget _buildEditableField(BuildContext context, String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          ),
        ),
      ],
    );
  }
}
