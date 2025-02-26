import 'package:ewaste/pages/OrderSummaryPage.dart';
import 'package:flutter/material.dart';
import 'package:ewaste/presentations/user/B2B/Details/widgets/business_info.dart';
import 'package:ewaste/presentations/user/B2B/Details/widgets/pickup_logistics.dart';
import 'package:ewaste/presentations/user/B2B/Details/widgets/pricing_payment.dart';
import 'package:ewaste/presentations/user/B2B/Details/widgets/scrap_details.dart';

class EnterDetailsPage extends StatefulWidget {
  @override
  _EnterDetailsPageState createState() => _EnterDetailsPageState();
}

class _EnterDetailsPageState extends State<EnterDetailsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _sections = [
    BusinessInfoSection(),
    ScrapDetailsSection(),
    PickupLogisticsSection(),
    PricingPaymentSection(),
  ];

  void _nextPage() {
    if (_currentPage < _sections.length - 1) {
      setState(() {
        _currentPage++;
        _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(title: Text("Enter Details", style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              children: _sections,
            ),
          ),
          _buildNavigationButtons(),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentPage > 0
              ? FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: _prevPage,
            child: Icon(Icons.arrow_back, color: Colors.white),
          )
              : SizedBox(width: 56),
          _currentPage < _sections.length - 1
              ? FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: _nextPage,
            child: Icon(Icons.arrow_forward, color: Colors.white),
          )
              : FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: _submitForm,
            child: Icon(Icons.check, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    // Placeholder for Firebase submission logic
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>OrderSummaryPage ()),
    );

  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _sections.length,
              (index) => AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: _currentPage == index ? 16 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: _currentPage == index ? Colors.blueAccent : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
