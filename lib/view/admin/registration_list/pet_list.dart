import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/update_controller.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/view/admin/registration_list/admin_pet_details.dart';

class PetListScreen extends StatelessWidget {
  final UpdateController controller = Get.put(UpdateController());

  PetListScreen({super.key}) {
    controller.fetchAllPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
        backgroundColor: kAppBarColor,
        title: Text(
          'Registered Pets',
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

        if (controller.allPetsList.isEmpty) {
          return const Center(child: Text("No pets found."));
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
          itemCount: controller.allPetsList.length,
          itemBuilder: (context, index) {
            final pet = controller.allPetsList[index];

            return GestureDetector(
              onTap: () {
                controller.fetchUpdates(pet.petUid);
                Get.to(() => AdminPetDetailsScreen(petUid: pet.petUid),
                    transition: Transition.rightToLeft);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.teal.shade100,
                      child: Text(
                        pet.petName.isNotEmpty ? pet.petName[0].toUpperCase() : '?',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ),
                    title: Text(
                      pet.petName,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      "Owner: ${pet.ownerName}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.black45, size: 20),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
