import 'package:flutter/material.dart';

import '../volunteer_verification.dart';

class ReachedButton extends StatelessWidget {
  final String requestId;

  const ReachedButton({Key? key, required this.requestId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationPage(requestId: requestId),
          ),
        );
      },
      child: Text("Reached Pickup Spot"),
    );
  }
}
