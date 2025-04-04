import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/data_controller.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/widgets/intro_widgets.dart';
import 'package:simanja/utils/widgets/service_tile.dart';
import 'package:simanja/utils/widgets/single_line_text_menu.dart';
import 'package:simanja/view/user/information/faq.dart';
import 'package:simanja/view/user/information/form_list.dart';
import 'package:simanja/view/user/information/updates.dart';
import 'package:simanja/view/user/services/food.dart';
import 'package:simanja/view/user/services/grooming.dart';
import 'package:simanja/view/user/services/medicine.dart';
import 'package:simanja/view/user/services/veterinary.dart';
import 'information/about_us.dart';
import 'information/my_pets/my_pets.dart';

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
              const IntroWidgets(),

              ///Services
              const SingleLineTextMenu( title: "Services",),
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
              const SingleLineTextMenu( title: "Information",),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> MyPetsScreen(),transition: Transition.rightToLeft);
                    },
                    imageUrl: cat,
                    title: 'My Pets',
                  ),
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> UserViewPostPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: update,
                    title: 'Updates',
                  ),

                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> const FormList(),transition: Transition.rightToLeft);
                    },
                    imageUrl: form,
                    title: 'Fill Form',
                  ),
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> const FAQPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: faqs,
                    title: 'FAQ',
                  ),

                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: (){
                      Get.to(()=> const AboutUsPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: about,
                    title: 'About Us',
                  ),
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


