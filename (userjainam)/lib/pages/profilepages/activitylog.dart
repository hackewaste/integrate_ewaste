import 'package:flutter/material.dart';

class ActivityLogPage extends StatelessWidget {
  const ActivityLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity Log')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10, // Example data count
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              leading: const Icon(Icons.history, color: Colors.blue),
              title: Text('Activity #$index'),
              subtitle: Text('Completed on: ${DateTime.now().subtract(Duration(days: index)).toLocal()}'),
            ),
          );
        },
      ),
    );
  }
}