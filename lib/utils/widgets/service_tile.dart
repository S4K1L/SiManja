import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simanja/utils/theme/colors.dart';

class ServiceTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onPress;
  const ServiceTile({
    super.key, required this.imageUrl, required this.title, required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 160.sp,
        width: 140.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.sp),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Light shadow color
              spreadRadius: 2,                      // How much the shadow spreads
              blurRadius: 8,                         // Softness of the shadow
              offset: Offset(4, 4),                  // Position of the shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 8.sp),
            Container(
              height: 120.sp,
              width: 120.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
                color: Colors.blue.withOpacity(0.4),
              ),
              child: Image.asset(imageUrl),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}