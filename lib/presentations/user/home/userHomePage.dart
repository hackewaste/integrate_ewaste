import 'package:ewaste/pages/EarnPage.dart';
import 'package:ewaste/presentations/user/home/widgets/collaboration.dart';
import 'package:ewaste/presentations/user/user_appbar.dart';
import 'package:ewaste/presentations/user/user_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'widgets/b2b_widget.dart';
import 'widgets/header_section.dart';
import 'widgets/referral.dart';
import 'widgets/stats/circular_progress.dart';
import 'widgets/stats/datewise_stats.dart';
import 'widgets/stats/overall_stats.dart';
import 'widgets/steps_section.dart';
import 'widgets/upcoming_events.dart';



class  UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppbar(),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(context),
              const SizedBox(height: 24.0),
              UpcomingEventsSection(),
              const SizedBox(height: 24.0),
              StepsSection(),
              const SizedBox(height: 24.0),
              B2BPostSection(context),
              const SizedBox(height: 24.0),
              InviteSection(context),
              const SizedBox(height: 24.0),
              ColabSection(context),
              const SizedBox(height: 24.0),
              OverallStatisticsSection(),
              const SizedBox(height: 24.0),
              buildDateSelector(),
              const SizedBox(height: 24.0),
              buildDailyActivity()
            ],
          ),
        ),
      ),
      bottomNavigationBar: UserBottomNavigation()
    );
  }
}


