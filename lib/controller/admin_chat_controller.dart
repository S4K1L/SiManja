import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AdminChatController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  var selectedUserId = "".obs;
  final TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  // Initialize notifications
  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Fetch list of users with active chats
  Stream<QuerySnapshot> getUsersList() {
    return firestore.collection('chatRooms').snapshots();
  }

  // Fetch messages for a specific chat room
  Stream<QuerySnapshot> getMessagesStream(String userId) {
    return firestore
        .collection('chatRooms')
        .doc(userId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Send message (Admin to User)
  void sendMessage(String userId) async {
    if (messageController.text.trim().isNotEmpty) {
      String adminId = auth.currentUser!.uid;
      String adminName = "Admin";

      DocumentReference chatRoomRef = firestore.collection('chatRooms').doc(userId);

      await chatRoomRef.set({
        'userId': userId,
        'lastMessage': messageController.text.trim(),
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await chatRoomRef.collection('messages').add({
        'senderId': adminId,
        'senderName': adminName,
        'message': messageController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'isAdmin': true,
        'isRead': false,
      });

      sendNotificationToUser(userId, messageController.text.trim());
      messageController.clear();
    }
  }

  // Send notification to the user
  void sendNotificationToUser(String userId, String message) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      "New Message from Admin",
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'admin_chat_channel',
          'Admin Chat',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  // Delete entire chat conversation with a user
  Future<void> deleteChat(String userId) async {
    try {
      DocumentReference chatRoomRef = firestore.collection('chatRooms').doc(userId);

      // Delete all messages in the chat
      QuerySnapshot messagesSnapshot = await chatRoomRef.collection('messages').get();
      for (DocumentSnapshot message in messagesSnapshot.docs) {
        await message.reference.delete();
      }

      // Delete chat room document
      await chatRoomRef.delete();

      // If the deleted chat was selected, reset the selected user
      if (selectedUserId.value == userId) {
        selectedUserId.value = "";
      }

      Get.snackbar(
        "Chat Deleted",
        "The chat has been successfully deleted.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete chat: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
