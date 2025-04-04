import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/utils/theme/colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
          icon: const Icon(Icons.arrow_back_ios_new,color: kWhiteColor,),
        ),
        backgroundColor: kAppBarColor,
        title: Text(
          'About Us',
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
              /// Welcome Section
              Text(
                'Welcome to SiManja Pet Daycare!',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: kBlueColor,
                ),
              ),
              SizedBox(height: 10.sp),
              Text(
                "We feel that you regard your pet as your family member at SiManja Pet Daycare. Our commitment is to provide the best care for your pet when you're away, plus a great experience in the mix. Whether vacationing or having to work, we ensure that your pet shall be cared for by our excellently trained team with their highest care, concern, and affection.",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kBlackColor,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.sp),

              /// Why Choose Us Section
              Text(
                'Why Choose SiManja?',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: kBlueColor,
                ),
              ),
              SizedBox(height: 10.sp),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: Icon(Icons.people, color: kBlueColor),
                    title: Text('Professional & Friendly Staff',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Our trained staff takes good care of your cat.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                  ListTile(
                    leading: Icon(Icons.live_tv, color: kBlueColor),
                    title: Text('Live Updates',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Receive daily updates, images, and videos of your pet.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                  ListTile(
                    leading: Icon(Icons.home, color: kBlueColor),
                    title: Text('Safe & Cozy Facilities',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('A secure and stress-free environment.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                  ListTile(
                    leading: Icon(Icons.book_online, color: kBlueColor),
                    title: Text('Easy Booking System',
                        style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                    subtitle: Text('Simply book and manage your bookings through our app.',
                        style: TextStyle(color: kBlackColor)),
                  ),
                ],
              ),
              SizedBox(height: 20.sp),

              /// Booking Call to Action
              Text(
                "Your cat's happiness and well-being are most important to us! Book your cat's stay with SiManja today.",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: kBlueColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
