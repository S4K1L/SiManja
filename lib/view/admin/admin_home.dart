import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/data_controller.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/widgets/intro_widgets.dart';
import 'package:simanja/utils/widgets/service_tile.dart';
import 'package:simanja/view/admin/veterinary/add_veterinary.dart';
import 'package:simanja/view/admin/appointment_list.dart';
import 'package:simanja/view/admin/chat/admin_chat_page.dart';

import 'registration_list/pet_list.dart';
import 'veterinary/view_vaterinary.dart';

class AdminHome extends StatelessWidget {
  final DataController controller = Get.put(DataController());
  AdminHome({super.key});

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
                    Text(
                      "Welcome, Admin",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "AvarezoSerif",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                  ],
                ),
              ),
              IntroWidgets(),

              ///information
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
                      Get.to(()=>  PetListScreen(),transition: Transition.rightToLeft);
                    },
                    imageUrl: update,
                    title: 'Activity',
                  ),
                  ServiceTile(
                    onPress: (){
                      Get.to(()=>  AdminChatPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: message,
                    title: 'Message',
                  ),

                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: (){
                      Get.to(()=>  AppointmentListPage(),transition: Transition.rightToLeft);
                    },
                    imageUrl: about,
                    title: 'Appointment',
                  ),
                  ServiceTile(
                    onPress: (){
                      Get.to(()=>  ViewVeterinaryList(),transition: Transition.rightToLeft);
                    },
                    imageUrl: vet,
                    title: 'Veterinary',
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
