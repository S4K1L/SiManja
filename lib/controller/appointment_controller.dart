import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simanja/models/appointment_model.dart';

class AppointmentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final ownerNameController = TextEditingController();
  final petNameController = TextEditingController();
  final appointmentDateController = TextEditingController();
  final contactNumberController = TextEditingController();
  final reasonController = TextEditingController();
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var userAppointments = <AppointmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserAppointments();
  }

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
        // Create a document reference to get the generated ID
        DocumentReference docRef = FirebaseFirestore.instance.collection('appointments').doc();

        await docRef.set({
          'user_uid': user.uid,
          'ownerName': ownerNameController.text.trim(),
          'petName': petNameController.text.trim(),
          'status': "Pending",
          'docId': docRef.id,
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
          margin: const EdgeInsets.only(bottom: 20),
        );
        clearFields();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to book appointment. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 20),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void fetchUserAppointments() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      userAppointments.clear();
      isLoading.value = false;
      return;
    }

    FirebaseFirestore.instance
        .collection('appointments')
        .where('user_uid', isEqualTo: currentUser.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      userAppointments.value = snapshot.docs
          .map((doc) => AppointmentModel.fromFirestore(doc))
          .toList();
      isLoading.value = false;
    });
  }

  void deleteAppointment(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(docId)
          .delete();

      Get.snackbar(
        'Deleted',
        'Appointment deleted successfully.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete appointment. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20),
      );
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