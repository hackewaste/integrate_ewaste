import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RealTimeLeaderboard extends StatefulWidget {
  const RealTimeLeaderboard({Key? key}) : super(key: key);

  @override
  _RealTimeLeaderboardState createState() => _RealTimeLeaderboardState();
}

class _RealTimeLeaderboardState extends State<RealTimeLeaderboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _userCredits = [];

  @override
  void initState() {
    super.initState();
    _listenToUserCredits();
  }

   void _listenToUserCredits() {
    // ✅ Fetch usercredits and update leaderboard in real-time
    _firestore.collection('usercredits').snapshots().listen((snapshot) {
      setState(() {
        _userCredits = snapshot.docs.map((doc) {
          var data = doc.data();
          // Ensure uid, username, and credits are available
          return {
            'uid': doc.id,
            'username': data['username'] ?? 'Unknown', // Ensure username exists
            'credits': data['credits'] ?? 0,
          };
        }).toList();
        
        // ✅ Sort by credits in descending order
        _userCredits.sort((a, b) => (b['credits']).compareTo(a['credits']));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Credit Leaderboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF324F5E),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _userCredits.isNotEmpty
                      ? ((_userCredits.first['credits'] ?? 0) + 10).toDouble()
                      : 100,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < _userCredits.length) {
                            // ✅ Display the username on the X-axis
                            final name = _userCredits[value.toInt()]['username'] ?? 'Unknown';
                            return Transform.rotate(
                              angle: -0.5,
                              child: Text(name, style: const TextStyle(fontSize: 12)),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 60,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _userCredits.asMap().entries.map((entry) {
                    int index = entry.key;
                    var data = entry.value;
                    double credits = (data['credits']).toDouble();
                    // Highlight first-place user
                    Color barColor = index == 0 ? Colors.blueAccent : Colors.green;
                    return _buildBarGroup(index, credits, barColor);
                  }).toList(),
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
}
