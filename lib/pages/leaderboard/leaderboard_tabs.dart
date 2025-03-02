import 'package:flutter/material.dart';
import 'leaderboard1.dart';  // import Leaderboard1.dart
import 'dailyactivity.dart'; // import DailyActivity.dart

class LeaderboardTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, // Set initialIndex to 0 to show the 'All Users' tab by default
      length: 2, // Two tabs: one for All Users and one for your own activity
      child: Scaffold(
        appBar: AppBar(
          title: Text('Leaderboard'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Users'),
              Tab(text: 'Your Leaderboard'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RealTimeLeaderboard(), // Displays the leaderboard for all users
            MonthlyActivity(), // Displays the user's own leaderboard
          ],
        ),
      ),
    );
  }
}
