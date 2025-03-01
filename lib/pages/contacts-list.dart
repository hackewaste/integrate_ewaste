import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool _permissionGranted = false;
  
  // Mock contacts data
  final List<Map<String, dynamic>> _contacts = [
    {'name': 'John Doe', 'phone': '+1 234 567 8901', 'avatar': 'JD'},
    {'name': 'Jane Smith', 'phone': '+1 234 567 8902', 'avatar': 'JS'},
    {'name': 'Robert Johnson', 'phone': '+1 234 567 8903', 'avatar': 'RJ'},
    {'name': 'Emily Davis', 'phone': '+1 234 567 8904', 'avatar': 'ED'},
    {'name': 'Michael Brown', 'phone': '+1 234 567 8905', 'avatar': 'MB'},
    {'name': 'Sarah Wilson', 'phone': '+1 234 567 8906', 'avatar': 'SW'},
    {'name': 'David Taylor', 'phone': '+1 234 567 8907', 'avatar': 'DT'},
    {'name': 'Lisa Anderson', 'phone': '+1 234 567 8908', 'avatar': 'LA'},
    {'name': 'Thomas White', 'phone': '+1 234 567 8909', 'avatar': 'TW'},
    {'name': 'Jennifer Martin', 'phone': '+1 234 567 8910', 'avatar': 'JM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refer Contacts'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _permissionGranted 
        ? _buildContactsList() 
        : _buildPermissionRequest(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 149, 182, 209),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: 'Home',
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore), 
            label: 'Explore'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save), 
            label: 'Redeem'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: 'Profile'
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionRequest() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.contacts,
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 24),
          const Text(
            'Access Your Contacts',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'We need access to your contacts to help you refer friends to the e-waste recycling platform.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Simulate granting permission
              setState(() {
                _permissionGranted = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Allow Access',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Not Now',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search contacts',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              final contact = _contacts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: Text(
                    contact['avatar'],
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(contact['name']),
                subtitle: Text(contact['phone']),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Show a snackbar when invite is sent
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invitation sent to ${contact['name']}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Invite'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

