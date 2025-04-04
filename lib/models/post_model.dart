import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final DateTime date;

  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });

  factory PostModel.fromMap(Map<String, dynamic> data, String docId) {
    return PostModel(
      id: docId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}
