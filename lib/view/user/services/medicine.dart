import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';

class PetMedicinePage extends StatelessWidget {
  const PetMedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_new,color: kWhiteColor,)),
        backgroundColor: kAppBarColor,
        title: Text(
          'Pet Medicine Details',
          style: TextStyle(
            fontSize: 20.sp,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: "AvarezoSerif",
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Section
              Container(
                height: MediaQuery.of(context).size.height / 4.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Image.asset(medicine),
              ),
              SizedBox(height: 20.sp),

              /// Description Section
              Text(
                'Importance of Pet Medicines',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: kBlue2Color,
                ),
              ),
              SizedBox(height: 10.sp),
              Text(
                'Proper medication ensures your pet stays healthy by preventing and treating illnesses. Timely vaccination and supplements boost immunity and longevity.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kBlackColor,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 20.sp),

              /// Medicine Categories
              Text(
                'Categories of Medicines',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: kBlue2Color,
                ),
              ),
              SizedBox(height: 10.sp),

              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: Icon(Icons.healing, color: kBlue2Color),
                    title: Text('Antibiotics',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Treat bacterial infections effectively.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                  ListTile(
                    leading: Icon(Icons.vaccines, color: kBlue2Color),
                    title: Text('Vaccines',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Protect against common diseases.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                  ListTile(
                    leading: Icon(Icons.pets, color: kBlue2Color),
                    title: Text('Dewormers',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Eliminate internal parasites.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                  ListTile(
                    leading: Icon(Icons.add_reaction, color: kBlue2Color),
                    title: Text('Supplements',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Boost immunity and vitality.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                ],
              ),

              SizedBox(height: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
