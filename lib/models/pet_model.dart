import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simanja/models/pet_updates_model.dart';

class PetModel {
  String id;
  String ownerName;
  String petName;
  String petType;
  String petAge;
  String healthHistory;
  String specialNeeds;
  String contactNumber;
  String userUid;
  String petUid;
  String imageUrl;
  List<PetUpdateModel> updates;

  PetModel({
    required this.id,
    required this.ownerName,
    required this.petName,
    required this.petType,
    required this.petAge,
    required this.healthHistory,
    required this.specialNeeds,
    required this.contactNumber,
    required this.imageUrl,
    required this.userUid,
    required this.petUid,
    required this.updates,
  });

  // Factory method to create a PetModel from Firestore document
  factory PetModel.fromDocument(DocumentSnapshot doc, List<PetUpdateModel> petUpdates) {
    final data = doc.data() as Map<String, dynamic>;
    return PetModel(
      id: doc.id,
      ownerName: data['owner_name'] ?? '',
      userUid: data['user_uid'] ?? '',
      petUid: data['pet_uid'] ?? '',
      petName: data['pet_name'] ?? '',
      petType: data['pet_type'] ?? '',
      petAge: data['pet_age'] ?? '',
      healthHistory: data['pet_health_History'] ?? '',
      specialNeeds: data['pet_special_need'] ?? '',
      contactNumber: data['contact_number'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      updates: petUpdates, // Store updates
    );
  }

  // Convert model to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'owner_name': ownerName,
      'pet_name': petName,
      'user_uid': userUid,
      'pet_uid': petUid,
      'pet_type': petType,
      'pet_age': petAge,
      'pet_health_History': healthHistory,
      'pet_special_need': specialNeeds,
      'contact_number': contactNumber,
      'imageUrl': imageUrl,
    };
  }
}
