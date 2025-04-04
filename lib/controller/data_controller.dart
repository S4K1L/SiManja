import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/admin_chat_controller.dart';
import 'package:simanja/controller/appointment_controller.dart';
import 'package:simanja/controller/contact_us_controller.dart';
import 'package:simanja/controller/login_controller.dart';
import 'package:simanja/controller/pet_registration_controller.dart';
import 'package:simanja/controller/signup_controller.dart';
import 'package:simanja/controller/update_controller.dart';
import 'package:simanja/controller/veterinary_controller.dart';
import 'package:simanja/models/user_model.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/view/authentication/login.dart';

import 'add_update_controller.dart';

class DataController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = UserModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLoggedInUser();
  }


  // Fetch the logged-in user's data
  Future<void> fetchLoggedInUser() async {
    isLoading.value = true;
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(currentUser.uid).get();
        if (doc.exists) {
          user.value = UserModel.fromSnapshot(doc);
        } else {
          user.value = UserModel(); // Assign default empty model if no data found
          print("No user data found in Firestore");
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
      user.value = UserModel(); // Fallback to default empty model
    } finally {
      isLoading.value = false;
    }
  }

  // Logout the user
  Future<void> logout() async {
    try {
      await _auth.signOut();
      // Clear all models
      _clearState();

      Get.snackbar(
        'Logout Success',
        'You have successfully logged out!',
        colorText: kWhiteColor,
        backgroundColor: kPrimaryColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      );

      // Navigate to login page
      Get.offAll(()=> Login(),transition: Transition.rightToLeft);
    } catch (e) {
      debugPrint("Error logging out: $e");
      Get.snackbar('Error', 'Failed to log out. Please try again.');
    }
  }



  // Clear user-related state and controllers
  void _clearState() async {
    await Get.delete<LoginController>();
    await Get.delete<SignupController>();
    await Get.delete<AppointmentController>();
    await Get.delete<ContactUsController>();
    await Get.delete<DataController>();
    await Get.delete<VeterinaryController>();
    await Get.delete<PetRegistrationController>();
    await Get.delete<UpdateController>();
    await Get.delete<ContactUsController>();
    await Get.delete<AdminChatController>();
    await Get.delete<AddUpdateController>();
  }
}