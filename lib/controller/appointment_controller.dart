import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final ownerNameController = TextEditingController();
  final petNameController = TextEditingController();
  final appointmentDateController = TextEditingController();
  final contactNumberController = TextEditingController();
  final reasonController = TextEditingController();
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onClose() {
    ownerNameController.dispose();
    petNameController.dispose();
    appointmentDateController.dispose();
    contactNumberController.dispose();
    reasonController.dispose();
    super.onClose();
  }

  void bookAppointment() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      User? user = _auth.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }
      try {
        await FirebaseFirestore.instance.collection('appointments').add({
          'user_uid': user.uid,
          'ownerName': ownerNameController.text.trim(),
          'petName': petNameController.text.trim(),
          'appointmentDate': appointmentDateController.text.trim(),
          'contactNumber': contactNumberController.text.trim(),
          'reason': reasonController.text.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        });

        Get.snackbar(
          'Success',
          'Appointment booked successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20),
        );
        clearFields();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to book appointment. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void clearFields() {
    ownerNameController.clear();
    petNameController.clear();
    appointmentDateController.clear();
    contactNumberController.clear();
    reasonController.clear();
  }
}