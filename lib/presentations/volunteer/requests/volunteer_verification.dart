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
  final TextEditingController _otpController = TextEditingController();
  String? _generatedOtp;
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _fetchOtp();
  }

  Future<void> _fetchOtp() async {
    try {
      DocumentSnapshot requestSnapshot = await FirebaseFirestore.instance
          .collection('requests')
          .doc(widget.requestId)
          .get();

      if (requestSnapshot.exists && requestSnapshot.data() != null) {
        setState(() {
          _generatedOtp = requestSnapshot['otp'].toString().trim(); // Ensure OTP is string & trimmed
          _isLoading = false;
        });
        print("Fetched OTP: $_generatedOtp");
      }
    } catch (e) {
      print("Error fetching OTP: $e");
      setState(() => _isLoading = false);
    }
  }

  void _verifyOtp() async {
    if (_generatedOtp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP not loaded. Please wait.")),
      );
      return;
    }

    String enteredOtp = _otpController.text.trim(); // Trim user input
    print("Entered OTP: $enteredOtp");

    if (enteredOtp == _generatedOtp) {
      try {
        await FirebaseFirestore.instance
            .collection('requests')
            .doc(widget.requestId)
            .update({'status': 'verified'});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP Verified! Proceeding...")),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WasteVerificationPage(requestId: widget.requestId),
          ),
        );// Navigate back
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
              CircularProgressIndicator() // Show loading while fetching OTP
            else ...[
              Text("Enter OTP shared by the user"),
              SizedBox(height: 12),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter OTP",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyOtp,
                child: Text("Verify"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
