import 'dart:async';
import 'package:ewaste/presentations/volunteer/home/VolunteerHome.dart';
import 'package:ewaste/presentations/volunteer/requests/ewaste_verification.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class OtpVerificationPage extends StatefulWidget {
  final String requestId;

  const OtpVerificationPage({Key? key, required this.requestId}) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  String? _generatedOtp;
  bool _isLoading = true;
  Timer? _timer;
  int _timeRemaining = 600; // 10 minutes in seconds
//ikkpk
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _fetchOtp();
    _startTimer();
  }

  Future<void> _fetchOtp() async {
    try {
      DocumentSnapshot requestSnapshot = await FirebaseFirestore.instance
          .collection('requests')
          .doc(widget.requestId)
          .get();

      if (requestSnapshot.exists && requestSnapshot.data() != null) {
        setState(() {
          _generatedOtp = requestSnapshot['otp'].toString().trim();
          _isLoading = false;
        });
        print("Fetched OTP: $_generatedOtp");
      }
    } catch (e) {
      print("Error fetching OTP: $e");
      setState(() => _isLoading = false);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer?.cancel();
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Time expired! Returning to home.")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VolunteerHomePage1()),
      );
    }
  }

  void _verifyOtp() async {
    if (_generatedOtp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP not loaded. Please wait.")),
      );
      return;
    }

    String enteredOtp = _controllers.map((controller) => controller.text).join();
    print("Entered OTP: $enteredOtp");

    if (enteredOtp == _generatedOtp) {
      _timer?.cancel(); // Stop the timer if OTP is verified

      try {
        await FirebaseFirestore.instance
            .collection('requests')
            .doc(widget.requestId)
            .update({'status': 'verified'});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP Verified! Proceeding...")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WasteVerificationPage(requestId: widget.requestId),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating status. Try again!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP. Try again!")),
      );
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator()
            else ...[
              Text("Enter OTP shared by the user"),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => _buildOtpBox(index)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyOtp,
                child: Text("Verify"),
              ),
              SizedBox(height: 20),
              Text(
                "Time Remaining: ${_formatTime(_timeRemaining)}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
