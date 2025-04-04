import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simanja/controller/admin_chat_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/view/admin/chat/chat.dart';

class AdminChatPage extends StatelessWidget {
  final AdminChatController controller = Get.put(AdminChatController());

  AdminChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
        title: Text(
          'Admin Chat',
          style: TextStyle(
            fontSize: 20.sp,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: "AvarezoSerif",
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Left Panel - User List
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey.shade100, Colors.grey.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  )
                ],
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: controller.getUsersList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var users = snapshot.data!.docs;
                  if (users.isEmpty) {
                    return const Center(child: Text("No active chats yet."));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var userData = users[index].data() as Map<String, dynamic>;
                      String userId = userData['userId'] ?? users[index].id;
                      String userName = userData['userName'] ?? "Unknown User";

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: GestureDetector(
                          onTap: () {
                            controller.selectedUserId.value = userId;
                            Get.to(() => ChatScreen(userId: userId, userName: userName));
                          },
                          child: Obx(() => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: controller.selectedUserId.value == userId
                                  ? Colors.blue.shade100
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.blueAccent,
                                  child: Text(
                                    userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: Text(
                                    userName,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Delete Chat",
                                      titleStyle: TextStyle(fontWeight: FontWeight.bold),
                                      middleText: "Are you sure you want to delete this chat?",
                                      textConfirm: "Delete",
                                      textCancel: "Cancel",
                                      confirmTextColor: Colors.white,
                                      buttonColor: Colors.redAccent,
                                      onConfirm: () {
                                        controller.deleteChat(userId);
                                        Get.back();
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          )),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
