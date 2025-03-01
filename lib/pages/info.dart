import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../presentations/user/user_bottom_navigation.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _selectedCategoryIndex = 0;
  int _selectedBottomNavIndex = 0;

  final List<Widget> _pages = [
    const EventsPage(),
    const FAQPage(),
    const EducatePage(),
  ];

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _onBottomNavSelected(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Get to Know',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // "Get to Know" Bar with Category Buttons (Independent of Bottom Nav)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(
                  label: 'Events',
                  isSelected: _selectedCategoryIndex == 0,
                  onPressed: () => _onCategorySelected(0),
                ),
                CategoryButton(
                  label: 'FAQ',
                  isSelected: _selectedCategoryIndex == 1,
                  onPressed: () => _onCategorySelected(1),
                ),
                CategoryButton(
                  label: 'Educate',
                  isSelected: _selectedCategoryIndex == 2,
                  onPressed: () => _onCategorySelected(2),
                ),
              ],
            ),
          ),
          // Display the selected page content (Independent of Bottom Nav)
          Expanded(
            child: _pages[_selectedCategoryIndex],
          ),
        ],
      ),
        bottomNavigationBar: UserBottomNavigation(currentIndex: 1,)
    );
  }
}

// Reusable Category Button Widget
class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.deepPurple : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// Events Page
class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              "Events",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [],
                ),
                const SizedBox(height: 8),
                CalendarGrid(),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Upcoming Plans(2)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          ListView(
            shrinkWrap: true, // Important to make ListView work inside SingleChildScrollView
            physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling conflict
            children: const [
              EventCard(
                date: "Wed, Apr 28 • 5:30 PM",
                title: "Jo Malone London’s Mother’s Day Presents",
                location: "Radius Gallery • Santa Cruz, CA",
                imagePath: "https://via.placeholder.com/70",
              ),
              EventCard(
                date: "Sat, May 1 • 2:00 PM",
                title: "A Virtual Evening of Smooth Jazz",
                location: "Lot 13 • Oakland, CA",
                imagePath: "https://via.placeholder.com/70",
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class CalendarGrid extends StatefulWidget {
  const CalendarGrid({super.key});

  @override
  State<CalendarGrid> createState() => _CalendarGridState();
}

class _CalendarGridState extends State<CalendarGrid> {
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    // Initialize with current IST date
    currentDate = DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));
  }

  void _changeMonth(int increment) {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + increment, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final int currentMonth = currentDate.month;
    final int currentYear = currentDate.year;

    // Get month name
    final String monthName = DateFormat('MMMM').format(currentDate);

    // Get total days in the current month
    final int totalDays = DateTime(currentYear, currentMonth + 1, 0).day;

    // Get the first day of the month
    final int firstDayOfWeek = DateTime(currentYear, currentMonth, 1).weekday;

    final List<String> days = ["S", "M", "T", "W", "T", "F", "S"];

    // Get today's date for highlighting
    final DateTime now = DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));
    final bool isCurrentMonth = now.year == currentYear && now.month == currentMonth;
    final int today = isCurrentMonth ? now.day : -1;

    return Column(
      children: [
        // Month Header with Navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => _changeMonth(-1),
              icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
            ),
            Text(
              "$monthName $currentYear",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () => _changeMonth(1),
              icon: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Days of the Week
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: days.map((day) {
            return Text(
              day,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),

        // Calendar Grid
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(42, (index) {
            final int dayNum = index - firstDayOfWeek + 2;

            // Check if the day is valid (within the month's range)
            bool isValidDay = dayNum > 0 && dayNum <= totalDays;

            // Highlight today's date
            bool isToday = isValidDay && dayNum == today;

            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isToday ? Colors.deepPurple : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  isValidDay ? dayNum.toString() : "",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isToday ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}


class EventCard extends StatelessWidget {
  final String date;
  final String title;
  final String location;
  final String imagePath;

  const EventCard({
    required this.date,
    required this.title,
    required this.location,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(color: Colors.blueAccent)),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(location, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// FAQ Page
class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        InfoTile(
          title: 'What is waste?',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
        InfoTile(
          title: 'Waste Management',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
        InfoTile(
          title: 'Importance of waste management',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
        InfoTile(
          title: 'Types of waste',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
      ],
    );
  }
}

// Educate Page
class EducatePage extends StatelessWidget {
  const EducatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Educate",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Placeholder for Video
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 50,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title of skill field
            const Text(
              "Title of skill",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: "dismantaling and etch",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Customer care field
            const Text(
              "customer care",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: "ahmad@gmail.com",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Description of skill field
            const Text(
              "Description of skill",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              enabled: false,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: "dismantaling and etchxxxxxxxxxxxxxxxh",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Done Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Placeholder action for the Done button
                },
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Info Tile for FAQ Page
class InfoTile extends StatefulWidget {
  final String title;
  final String content;

  const InfoTile({required this.title, required this.content, super.key});

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(widget.title),
        trailing: Icon(
          _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.content,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}