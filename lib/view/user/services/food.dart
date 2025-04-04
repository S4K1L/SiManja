import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';

class CatFoodPage extends StatelessWidget {
  const CatFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
        backgroundColor: kAppBarColor,
        title: Text(
          'Cat Food Details',
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
                child: Image.asset(food),
              ),
              SizedBox(height: 20.sp),

              /// Description Section
              Text(
                'Importance of Proper Nutrition for Cats',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: kBlue2Color,
                ),
              ),
              SizedBox(height: 10.sp),
              Text(
                'A well-balanced diet is crucial for your cat’s health. Proper nutrition supports immunity, digestion, and overall well-being.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kBlackColor,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 20.sp),

              /// Food Categories
              Text(
                'Types of Cat Food',
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
                    leading: Icon(Icons.local_dining, color: kBlue2Color),
                    title: Text('Dry Food',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Promotes dental health and is easy to store.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                  ListTile(
                    leading: Icon(Icons.food_bank, color: kBlue2Color),
                    title: Text('Wet Food',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Helps with hydration and is more palatable.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                  ListTile(
                    leading: Icon(Icons.health_and_safety, color: kBlue2Color),
                    title: Text('Raw Diet',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Mimics natural diet but requires careful preparation.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                  ListTile(
                    leading: Icon(Icons.nightlife, color: kBlue2Color),
                    title: Text('Grain-Free Food',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Good for cats with allergies or sensitivities.',
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
