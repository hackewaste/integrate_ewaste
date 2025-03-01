import 'package:ewaste/pages/leaderboard/leaderboard_tabs.dart';
import 'package:flutter/material.dart';
// Import the target page

class LeaderBoardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LeaderboardTabs()), // Replace with your page
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[700], // Button color
        foregroundColor: Colors.white, // Text color
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text("See More"),
    );
  }
}
