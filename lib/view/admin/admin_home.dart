import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/widgets/service_tile.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

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
                      "SiManja",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "AvarezoSerif",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.4.sp),
                      child: IconButton(onPressed: (){

                      }, icon: Icon(
                        Icons.logout,
                        size: 26.sp,
                        color: kWhiteColor,
                      )),
                    ),
                  ],
                ),
              ),
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
                        "Pet Day Care System\nSiManja",
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
                    onPress: (){},
                    imageUrl: vet,
                    title: 'Veterinary',
                  ),
                  ServiceTile(
                    onPress: (){},
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
                    onPress: (){},
                    imageUrl: medicine,
                    title: 'Medicine',
                  ),
                  ServiceTile(
                    onPress: (){},
                    imageUrl: food,
                    title: 'Foods',
                  ),
                ],
              ),

              ///Services
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
                    onPress: (){},
                    imageUrl: update,
                    title: 'Updates',
                  ),
                  ServiceTile(
                    onPress: (){},
                    imageUrl: register,
                    title: 'Registration',
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceTile(
                    onPress: (){},
                    imageUrl: faqs,
                    title: 'FAQS',
                  ),
                  ServiceTile(
                    onPress: (){},
                    imageUrl: about,
                    title: 'About Us',
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
