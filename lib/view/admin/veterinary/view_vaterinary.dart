import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/veterinary_controller.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/view/admin/veterinary/add_veterinary.dart';

class ViewVeterinaryList extends StatelessWidget {
  final VeterinaryController controller = Get.put(VeterinaryController());

  ViewVeterinaryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
        title: Text(
          'Veterinary Info',
          style: TextStyle(
            fontSize: 20.sp,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: "AvarezoSerif",
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: () => Get.to(() => AddVeterinaryPage(), transition: Transition.rightToLeft),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.veterinaryList.isEmpty) {
          return const Center(child: Text("No veterinary information found."));
        }
        return Padding(
          padding: EdgeInsets.all(16.sp),
          child: ListView.separated(
            itemCount: controller.veterinaryList.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final vet = controller.veterinaryList[index];
              return _buildVeterinaryCard(
                name: vet['name'] ?? 'N/A',
                specialization: vet['specialization'] ?? 'N/A',
                contactNumber: vet['contactNumber'] ?? 'N/A',
                location: vet['location'] ?? 'N/A',
                docId: vet['docId'] ?? 'N/A',
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildVeterinaryCard({
    required String name,
    required String specialization,
    required String contactNumber,
    required String location,
    required String docId,
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: kAppBarColor.withOpacity(0.15),
                    child: Icon(Icons.person_outline, color: kAppBarColor),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Divider(thickness: 0.5, color: Colors.grey[300]),
              SizedBox(height: 8.h),
              _buildInfoRow(Icons.medical_services_outlined, 'Specialization', specialization),
              SizedBox(height: 6.h),
              _buildInfoRow(Icons.phone_outlined, 'Contact', contactNumber),
              SizedBox(height: 6.h),
              _buildInfoRow(Icons.location_on_outlined, 'Location', location),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              Get.defaultDialog(
                title: "Delete Veterinary",
                middleText: "Are you sure you want to delete this veterinary?",
                textConfirm: "Yes",
                textCancel: "No",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  controller.deleteVeterinary(docId);
                  Get.back();
                },
              );
            },
          ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.sp, color: Colors.grey[600]),
        SizedBox(width: 8.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              children: [
                TextSpan(
                  text: "$label: ",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
