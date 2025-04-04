import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/add_update_controller.dart';
import 'package:simanja/utils/components/custom_auth_button.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UpdatePetScreen extends StatelessWidget {
  final String petId;
  final AddUpdateController controller = Get.put(AddUpdateController());

  UpdatePetScreen({super.key, required this.petId});

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
                                controller.reasonController,
                                "Reason",
                                "Enter reason",
                                "Please enter reason"
                            ),
                            SizedBox(height: 16.sp),

                            // Pet's Name
                            textFormWidgets(
                                controller.detailsController,
                                "Description",
                                "Enter description",
                                "Please enter description"
                            ),
                            SizedBox(height: 16.sp),

                            // Pet Type
                            TextFormField(
                              controller: controller.timeController,
                              decoration: InputDecoration(
                                labelText: 'Date',
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
                                  controller.timeController.text =
                                  '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                                }
                              },
                            ),
                            SizedBox(height: 16.sp),

                            CustomAuthButton(
                              onPress: ()=> controller.submitUpdate(petId),
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
                    )),
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.sp)),
      ),
      validator: (value) => value!.isEmpty ? validation : null,
    );
  }
}
