import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/data/services/auth_service.dart';  // Import your AuthService

class MonthlyActivity extends StatefulWidget {
  @override
  _MonthlyActivityState createState() => _MonthlyActivityState();
}

class _MonthlyActivityState extends State<MonthlyActivity> {
  Map<String, int> monthlyCounts = {};
  bool isLoading = true;
  String selectedMonth = 'January';
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchMonthlyData();
  }

  Future<void> fetchMonthlyData() async {
    try {
      final currentUserId = AuthService().currentUser()?.uid; // Get current user ID

      if (currentUserId == null) {
        setState(() {
          errorMessage = "No user is logged in!";
          isLoading = false;
        });
        return;
      }

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('usertemporary')
          .where('status', isEqualTo: 'completed')
          .where('uid', isEqualTo: currentUserId) // Use dynamic user ID
          .get();

      Map<String, int> counts = {};

      for (var doc in snapshot.docs) {
        DateTime? scheduledDate;

        // Handle scheduledDate parsing
        if (doc['scheduledDate'] is Timestamp) {
          scheduledDate = (doc['scheduledDate'] as Timestamp).toDate();
        } else if (doc['scheduledDate'] is String) {
          scheduledDate = DateTime.tryParse(doc['scheduledDate']);
        }

        if (scheduledDate == null) continue;

        // Create a month-year key
        String monthKey = "${scheduledDate.year}-${scheduledDate.month.toString().padLeft(2, '0')}";

        // Count total detections
        var results = doc['results'] ?? [];
        int itemCount = 0;

        for (var result in results) {
          if (result['detections'] != null && result['detections'] is List) {
            itemCount += (result['detections'] as List).length;
          }
        }

        counts.update(monthKey, (value) => value + itemCount, ifAbsent: () => itemCount);
      }

      setState(() {
        monthlyCounts = counts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Oops! Something went wrong. Please try again.";
      });
    }
  }

  int getTotalForMonth(String month) {
    String yearMonth = "2025-${_getMonthIndex(month).toString().padLeft(2, '0')}";
    return monthlyCounts[yearMonth] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monthly Activity"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text("Fetching your activity..."),
                  ],
                )
              : errorMessage != null
                  ? Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Select a month to view your activity:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF324F5E),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButton<String>(
                          value: selectedMonth,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedMonth = newValue;
                              });
                            }
                          },
                          dropdownColor: Colors.white,
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
                          style: const TextStyle(color: Color(0xFF324F5E), fontSize: 18),
                          items: _getMonthNames()
                              .map<DropdownMenuItem<String>>((String month) =>
                                  DropdownMenuItem<String>(
                                    value: month,
                                    child: Text(month),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 40),
                        _buildMonthlyActivity(getTotalForMonth(selectedMonth), selectedMonth),
                        
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _buildMonthlyActivity(int itemCount, String month) {
    double progress = (itemCount / 100).clamp(0.0, 1.0);

    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$itemCount',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF324F5E),
                      ),
                    ),
                    Text(
                      month,
                      style: const TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          itemCount == 0
              ? "No activity found for $month."
              : "Great work! You had $itemCount detections in $month.",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF324F5E),
          ),
        ),
      ],
    );
  }

  List<String> _getMonthNames() {
    return [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
  }

  int _getMonthIndex(String month) {
    return _getMonthNames().indexOf(month) + 1;
  }
}
