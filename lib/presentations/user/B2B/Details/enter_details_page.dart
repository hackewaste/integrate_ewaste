import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'widgets/business_info.dart';
import 'widgets/scrap_details.dart';
import 'widgets/pickup_logistics.dart';
import 'widgets/pricing_payment.dart';

class EnterDetailsPage extends StatefulWidget {
  @override
  _EnterDetailsPageState createState() => _EnterDetailsPageState();
}

class _EnterDetailsPageState extends State<EnterDetailsPage> {
  int _currentIndex = 0;
  CarouselController _carouselController = CarouselController();

  final List<Widget> _sections = [
    BusinessInfoSection(),
    ScrapDetailsSection(),
    PickupLogisticsSection(),
    PricingPaymentSection(),
  ];

  void _nextSection() {
    if (_currentIndex < _sections.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _carouselController.nextPage();
    }
  }

  void _prevSection() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _carouselController.previousPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Details")),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.75,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: _sections.map((widget) => Container(child: widget)).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentIndex > 0)
                FloatingActionButton(
                  onPressed: _prevSection,
                  child: Icon(Icons.arrow_back),
                ),
              FloatingActionButton(
                onPressed: _nextSection,
                child: Icon(_currentIndex == _sections.length - 1 ? Icons.check : Icons.arrow_forward),
              ),
            ],
          ),
          SizedBox(height: 20),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _sections.length,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: _currentIndex == index ? 12 : 8,
                  height: _currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
