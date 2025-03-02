import 'package:ewaste/presentations/volunteer/requests/ewaste_verification.dart';
import 'package:ewaste/presentations/volunteer/requests/volunteer_verification.dart';
import 'package:flutter/material.dart';

class ReachedButton extends StatefulWidget {
  final String requestId;

  const ReachedButton({Key? key, required this.requestId}) : super(key: key);

  @override
  _ReachedButtonState createState() => _ReachedButtonState();
}

class _ReachedButtonState extends State<ReachedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
    );
    _scaleAnimation = _controller.drive(Tween(begin: 1.0, end: 0.95));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(), // Shrink effect
      onTapUp: (_) => _controller.forward(),   // Back to normal size
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OtpVerificationPage(requestId: widget.requestId)));
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blue.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade300.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                "Reached",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
