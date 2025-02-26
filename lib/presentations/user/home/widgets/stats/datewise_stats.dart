
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildDateSelector() {
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
