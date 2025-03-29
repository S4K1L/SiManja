import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/widgets/service_tile.dart';
import 'package:simanja/view/user/form/appointment.dart';
import 'package:simanja/view/user/form/pet_registration.dart';

class FormList extends StatelessWidget {
  const FormList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Container(
                  height: MediaQuery.of(context).size.height / 6.5.sp,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                      color: kBlackColor),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16.sp,
                      ),
                      Text(
                        "Fill Form and\nSubmit",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: kWhiteColor,
                          fontFamily: "AvarezoSerif",
                        ),
                      ),
                      const Spacer(),
                      Image.asset(logo),
                    ],
                  ),
                ),
              ),

              ///Services
              Padding(
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
                      "Choose",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> PetRegistrationPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: register,
                    title: 'Registration',
                  ),
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> AppointmentPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: appointment,
                    title: 'Appointment',
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: (){},
                    imageUrl: payment,
                    title: 'Make a Payment',
                  ),
                  ServiceTile(
                    onPress: (){},
                    imageUrl: contact,
                    title: 'Contact Us',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
