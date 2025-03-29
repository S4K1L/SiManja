import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/login_controller.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/components/custom_auth_button.dart';
import 'package:simanja/view/authentication/signup.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final controller = Get.put(LoginController());

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
                        Icon(Icons.keyboard_arrow_down_outlined, size: 32.sp),
                        SizedBox(height: 16.sp),

                        // Wrap each field with Skeletonizer if needed
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
                          onPress: controller.login,
                          title: "Login",
                        ),
                        SizedBox(height: 16.sp),
                        TextButton(
                          onPressed: () {
                            Get.to(()=> Signup(),transition: Transition.rightToLeft);
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Don't have an account? "),
                              Text(
                                "Signup here",
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