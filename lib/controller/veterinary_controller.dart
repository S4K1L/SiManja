import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VeterinaryController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = true.obs;
  var veterinaryList = <Map<String, dynamic>>[].obs;
  final nameController = TextEditingController();
  final specializationController = TextEditingController();
  final contactNumberController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchVeterinaryData();
  }

  void fetchVeterinaryData() async {
    try {
      FirebaseFirestore.instance
          .collection('veterinary')
          .snapshots()
          .listen((snapshot) {
        veterinaryList.value = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addVeterinary() async {
    if (nameController.text.isEmpty ||
        specializationController.text.isEmpty ||
        contactNumberController.text.isEmpty ||
        locationController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection('veterinary').add({
        'name': nameController.text.trim(),
        'specialization': specializationController.text.trim(),
        'contactNumber': contactNumberController.text.trim(),
        'location': locationController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'Veterinary added successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
      clearFields();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add veterinary: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    nameController.clear();
    specializationController.clear();
    contactNumberController.clear();
    locationController.clear();
  }

  Future<void> deleteVeterinary(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('veterinary').doc(docId).delete();
      Get.snackbar(
        'Deleted',
        'Veterinary deleted successfully.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete veterinary: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20),
      );
    }
  }


  @override
  void onClose() {
    nameController.dispose();
    specializationController.dispose();
    contactNumberController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
