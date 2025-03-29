import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetRegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final ownerNameController = TextEditingController();
  final petNameController = TextEditingController();
  final petTypeController = TextEditingController();
  final petAgeController = TextEditingController();
  final contactNumberController = TextEditingController();
  var isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onClose() {
    ownerNameController.dispose();
    petNameController.dispose();
    petTypeController.dispose();
    petAgeController.dispose();
    contactNumberController.dispose();
    super.onClose();
  }

  void registerPet() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        User? user = _auth.currentUser;

        if (user == null) {
          throw Exception("User not logged in");
        }

        await _firestore.collection('pet_registration').add({
          'owner_name': ownerNameController.text.trim(),
          'pet_name': petNameController.text.trim(),
          'pet_type': petTypeController.text.trim(),
          'pet_age': petAgeController.text.trim(),
          'contact_number': contactNumberController.text.trim(),
          'user_uid': user.uid,
          'timestamp': FieldValue.serverTimestamp(),
        });

        Get.snackbar(
          'Registration Successful',
          'Your pet has been registered successfully.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20),
        );
        clearFields();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to register pet. Please try again.\nError: $e',
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
    petTypeController.clear();
    petAgeController.clear();
    contactNumberController.clear();
  }
}