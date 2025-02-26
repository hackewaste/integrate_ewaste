
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget OverallStatisticsSection() {
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
        fromY: 0,           // Starting point of the bar (can be 0 or any other value)
        toY: y,             // Ending point of the bar (replace 'y' with the actual value, it should be a valid double)
        color: color,       // The color of the bar
        width: 20,          // The width of the bar
        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)), // Styling the bar's top border
      )
    ],
  );
}
