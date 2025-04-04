import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simanja/controller/post_controller.dart';
import 'package:simanja/utils/theme/colors.dart';

class UserViewPostPage extends StatelessWidget {
  final UpdatesPostController controller = Get.put(UpdatesPostController());
  UserViewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
        title: Text(
          'Updates',
          style: TextStyle(
            fontSize: 20.sp,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: "AvarezoSerif",
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.postList.isEmpty) {
          return const Center(child: Text("No posts available."));
        }
        return Padding(
          padding: EdgeInsets.all(16.sp),
          child: ListView.separated(
            itemCount: controller.postList.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final post = controller.postList[index];
              return _buildPostCard(
                title: post.title,
                description: post.description,
                imageUrl: post.image,
                date: post.date,
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildPostCard({
    required String title,
    required String description,
    required String imageUrl,
    required DateTime date,
  }) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          if (imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 180.h,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 10.h),
          Text(
            description,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 18.sp, color: Colors.grey[600]),
              SizedBox(width: 6.w),
              Text(
                DateFormat.yMMMMd().format(date),
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
