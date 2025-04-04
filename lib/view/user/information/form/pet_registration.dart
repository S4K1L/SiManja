import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/pet_registration_controller.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/components/custom_auth_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PetRegistrationPage extends StatelessWidget {
  PetRegistrationPage({super.key});

  final controller = Get.put(PetRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(background), fit: BoxFit.cover),
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
                child: Obx(() =>
                    Skeletonizer(
                      enabled: controller.isLoading.value,
                      enableSwitchAnimation: true,
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Pet Registration', style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.bold)),
                            SizedBox(height: 16.sp),

                            // Owner's Name
                            textFormWidgets(
                                controller.ownerNameController,
                                "Owner's Name",
                                "Enter owner's full name",
                                "Please enter owner's name"
                            ),
                            SizedBox(height: 16.sp),

                            // Pet's Name
                            textFormWidgets(
                                controller.petNameController,
                                "Pet's Name",
                                "Enter pet's name",
                                "Please enter pet's name"
                            ),
                            SizedBox(height: 16.sp),

                            // Pet Type
                            textFormWidgets(
                                controller.petTypeController,
                                "Pet Type",
                                "e.g., Persian, Siamese",
                                "Please enter pet type"
                            ),
                            SizedBox(height: 16.sp),

                            // Pet Age
                            textFormWidgets(
                              controller.petAgeController,
                              "Pet Age",
                              "Enter pet's age in years",
                              "Please enter pet's age",
                            ),
                            SizedBox(height: 16.sp),

                            //Health history
                            textFormWidgets(
                                controller.healthHistoryController,
                                "Health History",
                                "Enter health history",
                                "Please enter health history"
                            ),

                            SizedBox(height: 16.sp),

                            //Health history
                            textFormWidgets(
                                controller.specialNeedController,
                                "Special Need's",
                                "Enter special need's",
                                "Please enter special need's"
                            ),

                            SizedBox(height: 16.sp),

                            // Contact Number
                            textFormWidgets(
                              controller.contactNumberController,
                              "Contact Number",
                              "Enter contact number",
                                "Please enter contact number"
                            ),
                            SizedBox(height: 16.sp),

                            CustomAuthButton(
                              onPress: controller.registerPet,
                              title: "Register Pet",
                            ),

                            CircleAvatar(
                              radius: 26.sp,
                              backgroundColor: kSecondaryColor,
                              child: IconButton(onPressed: () {
                                Get.back();
                              },
                                  icon: const Icon(Icons.arrow_back_ios_new,
                                    color: kPrimaryColor,)),
                            )
                          ],
                        ),
                      ),
                    ),),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textFormWidgets(TextEditingController controller,
      String labelText, String hintText, String validation) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.sp)),
      ),
      validator: (value) => value!.isEmpty ? validation : null,
    );
  }
}
