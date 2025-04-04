import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simanja/models/pet_model.dart';
import 'package:simanja/models/pet_updates_model.dart';

class MyPetController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  var petsList = <PetModel>[].obs;
  var allPetsList = <PetModel>[].obs;
  var isLoading = false.obs;
  var petUpdates = <PetUpdateModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserPets();
  }

  void fetchAllPets() async {
    isLoading.value = true;
    try {
      var petDocs = await _firestore
          .collection('pet_registration')
          .orderBy('timestamp', descending: true)
          .get();

      List<Future<PetModel>> petFutures = petDocs.docs.map((petDoc) async {
        var updatesSnapshot = await petDoc.reference
            .collection('update')
            .orderBy('timestamp', descending: true)
            .get();

        List<PetUpdateModel> petUpdates =
        updatesSnapshot.docs.map((doc) => PetUpdateModel.fromFirestore(doc)).toList();

        return PetModel.fromDocument(petDoc, petUpdates);
      }).toList();

      allPetsList.value = await Future.wait(petFutures);
    } catch (e) {
      Get.snackbar("Error", "Failed to load pets: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch pet updates for a specific pet
  void fetchUpdates(String petUid) async {
    isLoading.value = true;
    try {
      var snapshot = await _firestore
          .collection('pet_registration')
          .doc(petUid)
          .collection('update')
          .orderBy('timestamp', descending: true)
          .get();

      petUpdates.value = snapshot.docs
          .map((doc) => PetUpdateModel.fromFirestore(doc))
          .toList();

    } catch (e) {
      Get.snackbar("Error", "Failed to fetch updates: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch and listen to real-time updates for a specific pet
  void fetchPetProfile(String petId) {
    isLoading.value = true;
    _firestore.collection('pet_registration').doc(petId).snapshots().listen((doc) async {
      if (doc.exists) {
        // Fetch updates for the pet
        var updatesSnapshot = await doc.reference.collection('update').orderBy('timestamp', descending: true).get();
        List<PetUpdateModel> petUpdates = updatesSnapshot.docs.map((doc) => PetUpdateModel.fromFirestore(doc)).toList();

        var pet = PetModel.fromDocument(doc, petUpdates);

        // Update the existing pet in the list
        int index = petsList.indexWhere((p) => p.petUid == petId);
        if (index != -1) {
          petsList[index] = pet;
        } else {
          petsList.add(pet);
        }
      }
      isLoading.value = false;
    }, onError: (e) {
      Get.snackbar("Error", "Failed to load pet profile: $e");
      isLoading.value = false;
    });
  }

  /// Fetch all pets along with their updates
  void fetchPets() async {
    isLoading.value = true;
    try {
      var petDocs = await _firestore.collection('pet_registration').get();

      List<PetModel> loadedPets = [];
      for (var petDoc in petDocs.docs) {
        var updatesSnapshot = await petDoc.reference.collection('update').orderBy('timestamp', descending: true).get();

        List<PetUpdateModel> petUpdates = updatesSnapshot.docs.map((doc) => PetUpdateModel.fromFirestore(doc)).toList();

        loadedPets.add(PetModel.fromDocument(petDoc, petUpdates));
      }

      petsList.value = loadedPets;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch pet details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch all pets registered by the logged-in user in real-time
  void fetchUserPets() {
    isLoading.value = true;
    User? user = _auth.currentUser;
    if (user == null) {
      Get.snackbar("Error", "User not logged in");
      isLoading.value = false;
      return;
    }

    _firestore
        .collection('pet_registration')
        .where('user_uid', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((querySnapshot) async {
      List<PetModel> loadedPets = [];

      for (var petDoc in querySnapshot.docs) {
        var updatesSnapshot = await petDoc.reference.collection('update').orderBy('timestamp', descending: true).get();
        List<PetUpdateModel> petUpdates = updatesSnapshot.docs.map((doc) => PetUpdateModel.fromFirestore(doc)).toList();

        loadedPets.add(PetModel.fromDocument(petDoc, petUpdates));
      }

      petsList.value = loadedPets;
      isLoading.value = false;
    }, onError: (e) {
      Get.snackbar("Error", "Failed to load pets: $e");
      isLoading.value = false;
    });
  }

  /// Update pet info and refresh the list
  Future<void> updatePetInfo(String petId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('pet_registration').doc(petId).update(updatedData);
      Get.snackbar("Success", "Pet profile updated successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to update pet profile: $e");
    }
  }

  /// Pick an image from the gallery and upload it to Firebase Storage
  Future<void> pickAndUploadPetImage(String petId) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      File imageFile = File(image.path);
      String filePath = "pet_images/$petId.jpg"; // Unique path for each pet
      Reference storageRef = _storage.ref().child(filePath);

      // Upload image to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the image URL
      await _firestore.collection('pet_registration').doc(petId).update({
        "imageUrl": imageUrl,
      });

      Get.snackbar("Success", "Pet image uploaded successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
    }
  }

  Future<void> deletePet(String petUid) async {
    try {
      await FirebaseFirestore.instance.collection('pet_registration').doc(petUid).delete();
      allPetsList.removeWhere((pet) => pet.petUid == petUid);
      Get.snackbar("Deleted", "Pet has been removed successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete pet.");
    }
  }

}
