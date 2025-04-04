import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/appointment_controller.dart';
import 'package:simanja/utils/components/custom_auth_button.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppointmentPage extends StatelessWidget {
  final AppointmentController controller = Get.put(AppointmentController());

  AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image:
              DecorationImage(image: AssetImage(background), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
                color: kSecondaryColor,
              ),
              child: Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.sp),
                  color: kWhiteColor,
                ),
                child: Obx(() => Skeletonizer(
                      enabled: controller.isLoading.value,
                      enableSwitchAnimation: true,
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today,
                                size: 32.sp, color: kPrimaryColor),
                            SizedBox(height: 16.sp),
                            TextFormField(
                              controller: controller.ownerNameController,
                              decoration: InputDecoration(
                                labelText: 'Owner Name',
                                hintText: 'Enter your full name',
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.sp),
                                ),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter owner name'
                                  : null,
                            ),
                            SizedBox(height: 16.sp),
                            TextFormField(
                              controller: controller.petNameController,
                              decoration: InputDecoration(
                                labelText: 'Pet Name',
                                hintText: 'Enter your pet name',
                                prefixIcon: const Icon(Icons.pets),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.sp),
                                ),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter pet name'
                                  : null,
                            ),
                            SizedBox(height: 16.sp),
                            TextFormField(
                              controller: controller.appointmentDateController,
                              decoration: InputDecoration(
                                labelText: 'Appointment Date',
                                hintText: 'Select date',
                                prefixIcon: const Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.sp),
                                ),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Please select a date'
                                  : null,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  controller.appointmentDateController.text =
                                      '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                                }
                              },
                            ),
                            SizedBox(height: 16.sp),
                            TextFormField(
                              controller: controller.contactNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Contact Number',
                                hintText: 'Enter your phone number',
                                prefixIcon: const Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.sp),
                                ),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter contact number'
                                  : null,
                            ),
                            SizedBox(height: 16.sp),
                            TextFormField(
                              controller: controller.reasonController,
                              decoration: InputDecoration(
                                labelText: 'Reason for Appointment',
                                hintText: 'Enter reason for appointment',
                                prefixIcon: const Icon(Icons.note_alt),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.sp),
                                ),
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? 'Please enter reason' : null,
                            ),
                            SizedBox(height: 16.sp),
                            CustomAuthButton(
                              onPress: () {
                                controller.bookAppointment();
                              },
                              title: "Book Appointment",
                            ),
                            CircleAvatar(
                              radius: 26.sp,
                              backgroundColor: kSecondaryColor,
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: kPrimaryColor,
                                  )),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
