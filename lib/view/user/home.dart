import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/data_controller.dart';
import 'package:simanja/controller/login_controller.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/widgets/intro_widgets.dart';
import 'package:simanja/utils/widgets/service_tile.dart';
import 'package:simanja/view/user/information/faq.dart';
import 'package:simanja/view/user/information/form_list.dart';
import 'package:simanja/view/user/information/update/update.dart';
import 'package:simanja/view/user/services/food.dart';
import 'package:simanja/view/user/services/grooming.dart';
import 'package:simanja/view/user/services/medicine.dart';
import 'package:simanja/view/user/services/veterinary.dart';
import 'information/about_us.dart';

class Home extends StatelessWidget {
  final DataController controller = Get.put(DataController());
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                child: Row(
                  children: [
                    Obx((){return Text(
                      "Hi, ${controller.user.value.name.toString()}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "AvarezoSerif",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    );}),
                  ],
                ),
              ),
              IntroWidgets(),

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
                      "Services",
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
                      Get.to(()=> VeterinaryInfoPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: vet,
                    title: 'Veterinary',
                  ),
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> const PetGroomingPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: grooming,
                    title: 'Grooming',
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> const PetMedicinePage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: medicine,
                    title: 'Medicine',
                  ),
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> const CatFoodPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: food,
                    title: 'Foods',
                  ),
                ],
              ),

              ///Information
              SizedBox(height: 20.sp),
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
                      "Information",
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
                      Get.to(()=> UpdateScreen(),transition: Transition.rightToLeft);
                    },
                    imageUrl: update,
                    title: 'Updates',
                  ),
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> FormList(),transition: Transition.rightToLeft);
                    },
                    imageUrl: form,
                    title: 'Fill Form',
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> const FAQPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: faqs,
                    title: 'FAQ',
                  ),
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> const AboutUsPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: about,
                    title: 'About Us',
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: ()=> controller.logout(),
                    imageUrl: logout,
                    title: 'Logout',
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

