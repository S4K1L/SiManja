import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/pet_registration_controller.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/components/custom_auth_button.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../utils/constant/const.dart';

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
          image: DecorationImage(image: AssetImage(background), fit: BoxFit.cover),
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
                        Text('Pet Registration', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16.sp),

                        // Owner's Name
                        TextFormField(
                          controller: controller.ownerNameController,
                          decoration: InputDecoration(
                            labelText: "Owner's Name",
                            hintText: "Enter owner's full name",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.sp)),
                          ),
                          validator: (value) => value!.isEmpty ? "Please enter owner's name" : null,
                        ),
                        SizedBox(height: 16.sp),

                        // Pet's Name
                        TextFormField(
                          controller: controller.petNameController,
                          decoration: InputDecoration(
                            labelText: "Pet's Name",
                            hintText: "Enter pet's name",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.sp)),
                          ),
                          validator: (value) => value!.isEmpty ? "Please enter pet's name" : null,
                        ),
                        SizedBox(height: 16.sp),

                        // Pet Type
                        TextFormField(
                          controller: controller.petTypeController,
                          decoration: InputDecoration(
                            labelText: "Pet Type",
                            hintText: "e.g., Dog, Cat",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.sp)),
                          ),
                          validator: (value) => value!.isEmpty ? "Please enter pet type" : null,
                        ),
                        SizedBox(height: 16.sp),

                        // Pet Age
                        TextFormField(
                          controller: controller.petAgeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Pet Age",
                            hintText: "Enter pet's age in years",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.sp)),
                          ),
                          validator: (value) => value!.isEmpty ? "Please enter pet's age" : null,
                        ),
                        SizedBox(height: 16.sp),

                        // Contact Number
                        TextFormField(
                          controller: controller.contactNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Contact Number",
                            hintText: "Enter contact number",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.sp)),
                          ),
                          validator: (value) => value!.isEmpty ? "Please enter contact number" : null,
                        ),
                        SizedBox(height: 16.sp),

                        CustomAuthButton(
                          onPress: controller.registerPet,
                          title: "Register Pet",
                        ),

                        CircleAvatar(
                          radius: 26.sp,
                          backgroundColor: kSecondaryColor,
                          child: IconButton(onPressed: (){
                            Get.back();
                          }, icon: const Icon(Icons.arrow_back_ios_new,color: kPrimaryColor,)),
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
