import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? phone;
  final String? email;
  final String? name;

  UserModel({
    this.phone,
    this.email,
    this.name,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    return UserModel(
      phone: doc['phone'],
      email: doc['email'],
      name: doc['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
      'name': name
    };
  }
}