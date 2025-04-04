import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/appointment_controller.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/view/user/information/form/appointment.dart';

class ViewAppointmentPage extends StatelessWidget {
  final AppointmentController controller = Get.put(AppointmentController());

  ViewAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
        title: Text(
          'My Appointments',
          style: TextStyle(
            fontSize: 20.sp,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: "AvarezoSerif",
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.userAppointments.isEmpty) {
          return const Center(child: Text("No appointments found."));
        }

        return ListView.builder(
          itemCount: controller.userAppointments.length,
          itemBuilder: (context, index) {
            final appointment = controller.userAppointments[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.sp),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _info("Pet Name", appointment.petName),
                          _info("Date", appointment.appointmentDate),
                          _info("Contact", appointment.contactNumber),
                          _info("Reason", appointment.reason),
                          _info("Status", appointment.status),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(CupertinoIcons.signature, color: kGreenAccentColor,size: 32.sp,),
                        onPressed: () {

                        },
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: GestureDetector(
        onTap: ()=> Get.to(()=> AppointmentPage(),transition: Transition.rightToLeft),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.sp),
              topRight: Radius.circular(32.sp),
            ),
            color: kBlueColor
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Book Appointment",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,
                  fontFamily: "AvarezoSerif",color: kWhiteColor,letterSpacing: 0.5),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500,color: kBlueColor),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400,),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
