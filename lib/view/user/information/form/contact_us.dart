import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simanja/controller/contact_us_controller.dart';
import 'package:simanja/utils/theme/colors.dart';

class ContactUsPage extends StatelessWidget {
  final ContactUsController controller = Get.put(ContactUsController());

  ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: kWhiteColor,
            )),
        title:
            const Text('Day Care Staff', style: TextStyle(color: kWhiteColor,fontFamily: "AvarezoSerif")),
        backgroundColor: kAppBarColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.getMessagesStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    bool isAdmin = message['isAdmin'] ?? false;
                    return Align(
                      alignment: isAdmin
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5.sp, horizontal: 10.sp),
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                          color: isAdmin ? Colors.green[200] : Colors.blue[200],
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Text(
                          message['message'],
                          style: TextStyle(fontSize: 16.sp, color: kBlackColor),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: kBlueColor),
                  onPressed: controller.sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
