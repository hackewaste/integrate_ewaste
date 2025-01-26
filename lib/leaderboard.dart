import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF324F5E),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    _buildOverallStatistics(),
                    const SizedBox(height: 20),
                    _buildDateSelector(),
                    const SizedBox(height: 20),
                    _buildDailyActivity(),
                    const SizedBox(height: 20),
                    _buildGamificationSection(),
                    const SizedBox(height: 20),
                    _buildRecyclingProgressDashboard(),
                    const SizedBox(height: 20),
                    _buildStatisticsCards(),
                    const SizedBox(height: 20),
                    _buildWasteItem(),
                  ],
                ),
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.arrow_back, color: Colors.white),
          const Spacer(),
          const Text(
            'Total Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildOverallStatistics() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overall statistics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF324F5E),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 8,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _buildBarGroup(0, 6, Colors.green),
                    _buildBarGroup(1, 4, Colors.red),
                    _buildBarGroup(2, 7, Colors.amber),
                    _buildBarGroup(3, 5, Colors.green),
                    _buildBarGroup(4, 3, Colors.red),
                    _buildBarGroup(5, 4, Colors.green),
                    _buildBarGroup(6, 5, Colors.amber),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: y,
          color: color,
          width: 20,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    final now = DateTime.now();
    final dates = List.generate(7, (index) => now.add(Duration(days: index)));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dates.map((date) {
        final isToday = date.day == now.day;
        final textColor = isToday ? Colors.orange : const Color(0xFF324F5E);
        final bgColor = isToday ? Colors.orange : Colors.transparent;

        return Column(
          children: [
            Text(
              DateFormat('EEE').format(date),
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 4),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    color: isToday ? Colors.white : textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildDailyActivity() {
    return Row(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: 0.75,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '20',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF324F5E),
                      ),
                    ),
                    Text(
                      'June',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF324F5E),
                ),
              ),
              const SizedBox(height: 10),
              _buildActivityLegendItem('Recycled Electronics', Colors.green),
              _buildActivityLegendItem('Waste Collected', Colors.amber),
              _buildActivityLegendItem('Volunteers Participated', Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityLegendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildGamificationSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gamification: Leaderboards & Achievements',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF324F5E),
              ),
            ),
            const SizedBox(height: 10),
            _buildLeaderboardItem('Top Recycler', 'Alice', '500 items'),
            _buildLeaderboardItem('2nd Place', 'Bob', '400 items'),
            _buildLeaderboardItem('3rd Place', 'Charlie', '350 items'),
            const SizedBox(height: 10),
            const Text(
              'Achievements Unlocked',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF324F5E),
              ),
            ),
            _buildAchievementItem('First Recycler', Icons.star),
            _buildAchievementItem('Top Volunteer', Icons.star_border),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(String rank, String name, String points) {
    return Row(
      children: [
        Text(rank, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text(name),
        const Spacer(),
        Text(points, style: const TextStyle(color: Colors.green)),
      ],
    );
  }

  Widget _buildAchievementItem(String achievement, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(width: 8),
          Text(achievement),
        ],
      ),
    );
  }

  Widget _buildRecyclingProgressDashboard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recycling Progress (Regional Data)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF324F5E),
              ),
            ),
            const SizedBox(height: 20),
            _buildRecyclingProgressCard('North Region', 70, Colors.green),
            _buildRecyclingProgressCard('South Region', 60, Colors.amber),
            _buildRecyclingProgressCard('East Region', 40, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildRecyclingProgressCard(String region, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(child: Text(region)),
          const SizedBox(width: 10),
          CircularProgressIndicator(
            value: progress / 100,
            strokeWidth: 6,
            color: color,
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(width: 10),
          Text('$progress%', style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal, // Scroll horizontally
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align items to the left
      children: [
        _buildStatisticsCard('Total Recycled', '1500 items', Colors.green),
        _buildStatisticsCard('Total Waste', '3000 items', Colors.red),
        _buildStatisticsCard('Volunteers', '300', Colors.amber),
      ],
    ),
  );
}

  Widget _buildStatisticsCard(String title, String value, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWasteItem() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Waste item details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF324F5E),
              ),
            ),
            const SizedBox(height: 20),
            _buildWasteItemCard('Hazardous', '200 items'),
            _buildWasteItemCard('Recyclable', '300 items'),
            _buildWasteItemCard('Non-recyclable', '150 items'),
            _buildWasteItemCard('Electric', '50 items'),
          ],
        ),
      ),
    );
  }

  Widget _buildWasteItemCard(String type, String quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(type),
          const Spacer(),
          Text(quantity, style: const TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF324F5E),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.white),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: Colors.white),
          label: 'Settings',
        ),
      ],
      onTap: (index) {
        // Handle bottom navigation tap
      },
    );
  }

}
