import 'package:flutter/material.dart';


class VideoCard extends StatelessWidget {
  const VideoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      shadowColor: Colors.black26,
      child: Container(
        width: double.infinity,
        height: 180, // Adjust height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black12, // Placeholder color
        ),
        child: Center(
          child: Text(
            "Video Coming Soon",
          ),
        ),
      ),
    );
  }
}
