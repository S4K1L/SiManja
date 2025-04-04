import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleLineTextMenu extends StatelessWidget {
  final String title;
  const SingleLineTextMenu({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "| ",
            style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5),
          )
        ],
      ),
    );
  }
}