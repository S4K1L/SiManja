import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String docId;
  final String ownerName;
  final String petName;
  final String appointmentDate;
  final String contactNumber;
  final String reason;
  final String userUid;
  String status;
  final Timestamp timestamp;


  AppointmentModel({
    required this.docId,
    required this.ownerName,
    required this.petName,
    required this.appointmentDate,
    required this.contactNumber,
    required this.reason,
    required this.userUid,
    required this.status,
    required this.timestamp,
  });

  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppointmentModel(
      docId: doc.id,
      ownerName: data['ownerName'] ?? '',
      petName: data['petName'] ?? '',
      userUid: data['user_uid'] ?? '',
      appointmentDate: data['appointmentDate'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      reason: data['reason'] ?? '',
      status: data['status'] ?? 'Pending',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
