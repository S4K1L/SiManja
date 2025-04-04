import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/my_pet_controller.dart';
import 'package:simanja/utils/theme/colors.dart';
import 'pet_details.dart';

class MyPetsScreen extends StatelessWidget {

  MyPetsScreen({super.key});

  final MyPetController controller = Get.put(MyPetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: kWhiteColor,),
        ),
        backgroundColor: kAppBarColor,
        title: Text(
          'My Pets',
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

        if (controller.petsList.isEmpty) {
          return const Center(child: Text("No pets found."));
        }

        return ListView.builder(
          itemCount: controller.petsList.length,
          itemBuilder: (context, index) {
            final pet = controller.petsList[index];
            return Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: kAppBarColor
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(pet.imageUrl),
                  ),
                  title: Text(pet.petName),
                  subtitle: Text("Type: ${pet.petType} | Age: ${pet.petAge} Years"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                      controller.fetchUpdates(pet.petUid);
                      Get.to(()=> PetDetailsScreen(petUid: pet.petUid), transition: Transition.rightToLeft);
                    },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
