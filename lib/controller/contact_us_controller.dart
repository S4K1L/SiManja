import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Stream to get messages for a specific user
  Stream<QuerySnapshot> getMessagesStream() {
    String userId = auth.currentUser!.uid;

    return firestore
        .collection('chatRooms')
        .doc(userId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Sending a message
  void sendMessage({bool isAdmin = false}) async {
    if (messageController.text.trim().isNotEmpty) {
      String userId = auth.currentUser!.uid;
      String userName = auth.currentUser!.displayName ?? "Unknown User";

      // Ensure chat room document exists for the user
      DocumentReference chatRoomRef = firestore.collection('chatRooms').doc(userId);

      await chatRoomRef.set({
        'userId': userId,
        'userName': userName,
        'lastMessage': messageController.text.trim(),
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)); // Merge prevents overwriting existing data

      // Store message inside user's messages collection
      await chatRoomRef.collection('messages').add({
        'senderId': userId,
        'senderName': userName,
        'message': messageController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'isAdmin': isAdmin,
        'isRead': false, // To track unread messages
      });

      messageController.clear();
    }
  }
}
