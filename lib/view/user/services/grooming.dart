import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';

class PetGroomingPage extends StatelessWidget {
  const PetGroomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          'Pet Grooming Services',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "AvarezoSerif",
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Section
            Container(
              height: MediaQuery.of(context).size.height / 4.5.sp,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: Image.asset(grooming),
            ),
            SizedBox(height: 20.sp),

            /// Description Section
            Text(
              '| Why Grooming is Important?',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(height: 10.sp),
            Text(
              'Regular grooming keeps your pet healthy and comfortable. It helps in early detection of skin issues, removes dirt and dead hair, and maintains a shiny coat.',
              style: TextStyle(
                fontSize: 16.sp,
                color: kBlackColor,
                height: 1.5,
              ),
            ),

            SizedBox(height: 20.sp),

            /// Services Offered
            Text(
              ' | Services We Provide',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(height: 10.sp),

            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading:
                      const Icon(Icons.cut, color: Colors.deepPurpleAccent),
                  title: Text('Hair Trimming',
                      style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                  subtitle: const Text('Keep your pet neat and tidy.',
                      style: TextStyle(color: kBlackColor)),
                ),
                ListTile(
                  leading: const Icon(Icons.bathtub,
                      color: Colors.deepPurpleAccent),
                  title: Text('Bathing & Drying',
                      style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                  subtitle: const Text('Refresh and clean your pet.',
                      style: TextStyle(color: kBlackColor)),
                ),
                ListTile(
                  leading: const Icon(Icons.clean_hands,
                      color: Colors.deepPurpleAccent),
                  title: Text('Nail Clipping',
                      style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                  subtitle: const Text('Maintain healthy paws.',
                      style: TextStyle(color: kBlackColor)),
                ),
                ListTile(
                  leading:
                      const Icon(Icons.spa, color: Colors.deepPurpleAccent),
                  title: Text('Spa & Massage',
                      style: TextStyle(fontSize: 18.sp, color: kBlackColor)),
                  subtitle: const Text('Relaxation and care for your pet.',
                      style: TextStyle(color: kBlackColor)),
                ),
              ],
            ),

            SizedBox(height: 20.sp),
          ],
        ),
      ),
    );
  }
}
