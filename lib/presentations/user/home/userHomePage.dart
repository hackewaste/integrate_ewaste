import 'package:ewaste/pages/EarnPage.dart';
import 'package:ewaste/presentations/user/home/widgets/collaboration.dart';
import 'package:ewaste/presentations/user/home/widgets/disposal_widget.dart';
import 'package:ewaste/presentations/user/home/widgets/drawer.dart';
import 'package:ewaste/presentations/user/home/widgets/leaderboard_button.dart';
import 'package:ewaste/presentations/user/home/widgets/resale_section.dart';
import 'package:ewaste/presentations/user/user_appbar.dart';
import 'package:ewaste/presentations/user/user_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:ewaste/pages/profilepages/UserAccountPage1.dart';
import 'widgets/b2b_widget.dart';
import 'widgets/header_section.dart';
import 'widgets/referral.dart';
import 'widgets/stats/circular_progress.dart';
import 'widgets/stats/datewise_stats.dart';
import 'widgets/stats/overall_stats.dart';
import 'widgets/steps_section.dart';
import 'widgets/upcoming_events.dart';
import 'widgets/didyouknow.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation logic here based on index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppbar(),
      drawer: UserDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerSection(context),
              const SizedBox(height: 24.0),
              StepsSection(),
              const SizedBox(height: 24.0),
              B2BPostSection(context),
              const SizedBox(height: 24.0),
              EnvironmentalImpactCard(),
              const SizedBox(height: 24.0),
              upcomingEventsSection(context), 
              const SizedBox(height: 24.0),
              InviteSection(context),
              const SizedBox(height: 24.0),
              DisposalWidget(),
              const SizedBox(height: 24.0),
              ColabSection(context),
              const SizedBox(height: 24.0),
              OverallStatisticsSection(),
              const SizedBox(height: 24.0),
              ResaleSection(),
              const SizedBox(height: 24.0),
              buildDateSelector(),
              const SizedBox(height: 24.0),
              buildDailyActivity(),
              const SizedBox(height: 24.0),
              LeaderBoardButton()
            ],
          ),
        ),
      ),
      bottomNavigationBar: UserBottomNavigation(currentIndex: 0,)
    );
  }
}
