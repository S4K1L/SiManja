import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simanja/utils/theme/colors.dart';

class UpdateTiles extends StatelessWidget {
  final String reason;
  final String details;
  final String date;
  const UpdateTiles({
    super.key, required this.reason, required this.details, required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
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
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        color: Colors.grey.withOpacity(0.2)),
                    child: Icon(
                      Icons.pets,
                      color: kBlueColor,
                      size: 26.sp,
                    ),
                  ),
                  SizedBox(width: 8.sp,),
                  Text(reason, style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700,color: kBlueColor),)
                ],
              ),
              SizedBox(height: 8.sp,),
              Text(details,style: const TextStyle(color: kGreyColor),maxLines: 3,),
              SizedBox(height: 8.sp,),
              Text("Date: ", style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: kBlueColor),),
              Text(date.toString(), style: const TextStyle(color: kGreyColor),),
            ],
          ),
        ),
      ),
    );
  }
}