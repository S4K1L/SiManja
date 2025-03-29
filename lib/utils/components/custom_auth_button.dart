import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simanja/utils/theme/colors.dart';

class CustomAuthButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String? title;
  const CustomAuthButton({
    super.key, required this.onPress, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Container(
        height: 45.sp,
        width: MediaQuery.of(context).size.width / 1.1.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.sp),
            color: kSecondaryColor),
        child: TextButton(
          onPressed: onPress,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: kPrimaryColor),
              ),
              Icon(
                Icons.send,
                size: 28.sp,
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}