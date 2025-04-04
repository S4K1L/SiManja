import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';

class IntroWidgets extends StatelessWidget {
  const IntroWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Container(
        height: MediaQuery.of(context).size.height / 6.5.sp,
        width: MediaQuery.of(context).size.width,
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
        child: Row(
          children: [
            SizedBox(
              width: 16.sp,
            ),
            Text(
              "Pet Day Care System\nSiManja",
              style: TextStyle(
                fontSize: 18.sp,
                color: kBlackColor,
                fontFamily: "AvarezoSerif",
              ),
            ),
            const Spacer(),
            Image.asset(logo),
          ],
        ),
      ),
    );
  }
}