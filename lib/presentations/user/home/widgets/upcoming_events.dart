import 'package:flutter/material.dart';
import 'package:ewaste/pages/info.dart';

Widget upcomingEventsSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Upcoming Events',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage()),
              );
            },
            child: const Text('See All'),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      SizedBox(
        height: 160, // Adjust height as needed
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              eventCard(context, 'assets/download.jpg', 'Sell e-waste for business co-op'),
              const SizedBox(width: 8.0),
              eventCard(context, 'assets/download1.jpg', 'Community e-waste collection drive'),
              const SizedBox(width: 8.0),
              eventCard(context, 'assets/download2.jpg', 'Electronics Recycling Awareness'),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget eventCard(BuildContext context, String imagePath, String title) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InfoPage()),
      );
    },
    child: Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: 150, // Fixed width for consistency
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
