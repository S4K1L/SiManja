import 'package:cloud_firestore/cloud_firestore.dart';

class PetUpdateModel {
  final String reason;
  final String details;
  final String time;
  final Timestamp timestamp;

  PetUpdateModel({
    required this.reason,
    required this.details,
    required this.time,
    required this.timestamp,
  });

  factory PetUpdateModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PetUpdateModel(
      reason: data['reason'] ?? '',
      details: data['details'] ?? '',
      time: data['time'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
