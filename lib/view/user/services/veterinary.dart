import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/veterinary_controller.dart';

class VeterinaryInfoPage extends StatelessWidget {
  final VeterinaryController controller = Get.put(VeterinaryController());
  VeterinaryInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('Veterinary Information'),
        centerTitle: true,
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
          child: ListView.builder(
            itemCount: controller.veterinaryList.length,
            itemBuilder: (context, index) {
              final vet = controller.veterinaryList[index];
              return _buildVeterinaryCard(
                name: vet['name'] ?? 'N/A',
                specialization: vet['specialization'] ?? 'N/A',
                contactNumber: vet['contactNumber'] ?? 'N/A',
                location: vet['location'] ?? 'N/A',
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
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.sp),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.sp),
            Text(
              'Specialization: $specialization',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 8.sp),
            Text(
              'Contact: $contactNumber',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 8.sp),
            Text(
              'Location: $location',
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
