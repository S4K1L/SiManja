import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simanja/utils/theme/colors.dart';

class PetInfoDetails extends StatelessWidget {
  final String title1;
  final String title2;
  final String name1;
  final String name2;
  final IconData iconData1;
  final IconData iconData2;

  const PetInfoDetails(
      {super.key,
        required this.title1,
        required this.name1,
        required this.iconData1,
        required this.title2,
        required this.name2,
        required this.iconData2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: Colors.grey.withOpacity(0.4)),
                child: Icon(
                  iconData1,
                  color: kBlueColor,
                  size: 32,
                ),
              ),
              SizedBox(
                width: 8.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: kBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(name1),
                ],
              )
            ],
          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: Colors.grey.withOpacity(0.4)),
                child: Icon(
                  iconData2,
                  color: kBlueColor,
                  size: 32,
                ),
              ),
              SizedBox(
                width: 8.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title2,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: kBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(name2),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}