
import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              title: const Text('How to donate e-waste?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('You can donate by scheduling a pickup from the app!'),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('How to earn rewards?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('You earn rewards by recycling e-waste and referring friends.'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Support',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text('support@ewaste.com'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text('+1-800-123-4567'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
