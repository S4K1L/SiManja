import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/signup_controller.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/view/admin/admin_home.dart';
import 'package:simanja/view/authentication/login.dart';
import 'package:simanja/view/user/home.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = UserModel().obs;



  /// Login function
  Future<void> login() async {
    if (!_validateInputs()) return;
    isLoading.value = true;
    try {
    await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      isLoading.value = false;
      Get.snackbar(
        'Login Success',
        'You have successfully logged in!',
        colorText: kWhiteColor,
        backgroundColor: kPrimaryColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      );
      // Navigate to the appropriate route
      route();
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      String errorMessage = 'An unexpected error occurred. Please try again.';

      // Handle specific Firebase exceptions
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This user has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many login attempts. Please try again later.';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Please check your internet connection.';
          break;
        default:
          errorMessage = "Check your email and password";
      }

      // Show error message using GetX Snack bar
      Get.snackbar(
        'Login Failed',
        errorMessage,
        colorText: kWhiteColor,
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      );

      if (kDebugMode) {
        print('Login error: $errorMessage');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        colorText: kWhiteColor,
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      );
      if (kDebugMode) {
        print('Unknown error: $e');
      }
    }
  }


  void route() async {
    User? user = FirebaseAuth.instance.currentUser;

    var documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (documentSnapshot.exists) {
      String userType = documentSnapshot.get('role');
      if (userType == "user") {
        Get.to(()=>  Home(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 300));
      } else if (userType == "admin") {
        Get.to(()=>  AdminHome(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 300));
      } else {
        Get.snackbar(
          'Try again',
          'Some error in logging in!',
          colorText: kWhiteColor,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
        );
      }
    } else {
      if (kDebugMode) {
        print('user data not found');
      }
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      if (kDebugMode) {
        print('Error resetting password: $error');
      }
      rethrow;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool _validateInputs() {
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Error', 'Enter a valid email address',
        colorText: kWhiteColor,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),);
      return false;
    }
    if (passwordController.text.trim().length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters',
        colorText: kWhiteColor,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),);
      return false;
    }
    return true;
  }
}
