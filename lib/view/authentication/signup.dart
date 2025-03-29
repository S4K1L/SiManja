import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/signup_controller.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/components/custom_auth_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person_add_alt_1, size: 32.sp),
                        SizedBox(height: 16.sp),

                        // Name Field
                        Skeletonizer(
                          enabled: controller.isLoading.value,
                          child: TextFormField(
                            controller: controller.nameController,
                            decoration: InputDecoration(
                              labelText: "Name",
                              hintText: "Enter your full name",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.sp),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.sp),

                        // Phone Field
                        Skeletonizer(
                          enabled: controller.isLoading.value,
                          child: TextFormField(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Phone",
                              hintText: "Enter your phone number",
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.sp),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.sp),

                        // Email Field
                        Skeletonizer(
                          enabled: controller.isLoading.value,
                          child: TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Enter your email",
                              prefixIcon: const Icon(Icons.alternate_email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.sp),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.sp),

                        // Password Field
                        Skeletonizer(
                          enabled: controller.isLoading.value,
                          child: Obx(() => TextFormField(
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                onPressed: controller.togglePasswordVisibility,
                                icon: Icon(controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.sp),
                              ),
                            ),
                          )),
                        ),

                        SizedBox(height: 16.sp),
                        CustomAuthButton(
                          onPress: controller.signup,
                          title: "Signup",
                        ),
                        SizedBox(height: 16.sp),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Already have an account? "),
                              Text(
                                "Login here",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
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
