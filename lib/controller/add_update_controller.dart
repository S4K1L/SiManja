import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUpdateController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();
  final detailsController = TextEditingController();
  final timeController = TextEditingController();
  var isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void submitUpdate(String petId) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await _firestore.collection('pet_registration')
            .doc(petId)
            .collection('update')
            .add({
          'reason': reasonController.text.trim(),
          'details': detailsController.text.trim(),
          'time': timeController.text.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        });

        Get.snackbar(
          'Update Successful',
          'Pet update has been recorded.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20),
        );
        clearFields();
        Get.back();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to update pet details. Error: $e',
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
    reasonController.clear();
    detailsController.clear();
    timeController.clear();
  }

  @override
  void onClose() {
    reasonController.dispose();
    detailsController.dispose();
    timeController.dispose();
    super.onClose();
  }
}
