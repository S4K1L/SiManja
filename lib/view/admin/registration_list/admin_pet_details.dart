import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/my_pet_controller.dart';
import 'package:simanja/models/pet_model.dart';
import 'package:simanja/utils/constant/const.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'package:simanja/utils/widgets/pet_info_widget.dart';
import 'package:simanja/utils/widgets/update_tiles.dart';

import 'add_updates.dart';

class AdminPetDetailsScreen extends StatelessWidget {
  final String petUid;
  AdminPetDetailsScreen({super.key, required this.petUid});
  final MyPetController controller = Get.put(MyPetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
        backgroundColor: kAppBarColor,
        title: Text(
          'Cat Profile',
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

        final pet = controller.allPetsList.firstWhereOrNull((p) => p.petUid == petUid);
        if (pet == null) {
          return const Center(child: Text("Cat profile not found."));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildPetCard(pet),
              const SizedBox(height: 10),
              _buildSectionHeader(" | Cat's Activities",()=> Get.to(() => UpdatePetScreen(petId: pet.id),transition: Transition.rightToLeft),),
              Obx(() => controller.petUpdates.isEmpty
                  ? Center(child: Text("No updates available", style: TextStyle(fontSize: 16.sp)))
                  : Column(
                children: controller.petUpdates.map((update) => UpdateTiles(
                  reason: update.reason,
                  details: update.details,
                  date: update.time,
                )).toList(),
              )),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPetCard(PetModel pet) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPetImage(pet),
          const SizedBox(height: 10),
          _buildSectionHeader("Basic Info"),
          const Divider(color: kBlueColor),
          PetInfoDetails(
            title1: 'Name',
            name1: pet.petName,
            iconData1: Icons.pets,
            title2: 'Type',
            name2: pet.petType,
            iconData2: Icons.merge_type,
          ),
          PetInfoDetails(
            title1: 'Contact',
            name1: pet.contactNumber,
            iconData1: Icons.contact_mail_outlined,
            title2: 'Age',
            name2: pet.petAge,
            iconData2: Icons.history_edu_outlined,
          ),
          _buildInfoCard("Special Need's", pet.specialNeeds),
          _buildInfoCard("Health History", pet.healthHistory),
        ],
      ),
    );
  }

  Widget _buildPetImage(PetModel pet) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: pet.imageUrl.isNotEmpty ? NetworkImage(pet.imageUrl) : const AssetImage(vet) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.camera, color: kBlueColor),
          onPressed: () => controller.pickAndUploadPetImage(petUid),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, [VoidCallback? onEdit]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: kBlueColor)),
          if (onEdit != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
                color: kWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Light shadow color
                    spreadRadius: 2,                      // How much the shadow spreads
                    blurRadius: 8,                         // Softness of the shadow
                    offset: Offset(4, 4),                  // Position of the shadow
                  ),
                ],
              ),
              child: TextButton(
                onPressed: onEdit,
                child: Text("ADD",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.grey.withOpacity(0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" | $title", style: TextStyle(fontSize: 18.sp, color: kBlueColor, fontWeight: FontWeight.bold)),
            Text(content),
          ],
        ),
      ),
    );
  }

}
