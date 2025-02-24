import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgesWidget extends StatefulWidget {
  const BadgesWidget({super.key});

  @override
  _BadgesWidgetState createState() => _BadgesWidgetState();
}

class _BadgesWidgetState extends State<BadgesWidget> {
  int _currentIndex = 0;
  String? _voucherCode;

  // Method to display a voucher code when the image is clicked
  void _showVoucherCode(String code) {
    setState(() {
      _voucherCode = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 391,
        height: 803,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 27,
              left: 159,
              child: Text(
                'Redeem',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(76, 76, 76, 1),
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
            ),
            Positioned(
              top: 36,
              left: 36,
              child: SvgPicture.asset(
                'assets/images/vector5.svg',
                semanticsLabel: 'vector5',
                placeholderBuilder: (BuildContext context) =>
                    CircularProgressIndicator(),
              ),
            ),
            // Rectangle 1 with Image
            Positioned(
              top: 158,
              left: 17,
              child: GestureDetector(
                onTap: () => _showVoucherCode('VOUCHER1-12345'),
                child: Container(
                  width: 317,
                  height: 138,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/Image7.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Rectangle 2 with Image
            Positioned(
              top: 349,
              left: 17,
              child: GestureDetector(
                onTap: () => _showVoucherCode('VOUCHER2-67890'),
                child: Container(
                  width: 317,
                  height: 138,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/Image8.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Rectangle 3 with Image
            Positioned(
              top: 542,
              left: 17,
              child: GestureDetector(
                onTap: () => _showVoucherCode('VOUCHER3-11223'),
                child: Container(
                  width: 317,
                  height: 138,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/Image9.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Voucher Code Display
            if (_voucherCode != null)
              Positioned(
                top: 720,
                left: 17,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Your Voucher Code: $_voucherCode',
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
