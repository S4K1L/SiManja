import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/post_controller.dart';
import 'package:simanja/utils/theme/colors.dart';

class AddUpdatesPostPage extends StatelessWidget {
  final UpdatesPostController controller = Get.put(UpdatesPostController());

  AddUpdatesPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
        title: Text(
          'Create Post',
          style: TextStyle(
            fontSize: 20.sp,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: "AvarezoSerif",
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          children: [
            _buildTextField(
              label: "Title",
              hint: "Enter post title",
              onChanged: (val) => controller.title.value = val,
            ),
            SizedBox(height: 16.h),
            _buildTextField(
              label: "Description",
              hint: "Write something...",
              maxLines: 5,
              onChanged: (val) => controller.description.value = val,
            ),
            SizedBox(height: 16.h),
            Obx(() => GestureDetector(
              onTap: controller.pickImage,
              child: controller.selectedImage.value != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.file(
                  controller.selectedImage.value!,
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
                  : Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined, size: 40.sp, color: Colors.grey),
                      SizedBox(height: 8.h),
                      Text(
                        'Tap to upload image',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            SizedBox(height: 24.h),
            Obx(() => SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: controller.isUploading.value ? null : controller.uploadPost,
                child: controller.isUploading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Upload Post',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        TextField(
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}
