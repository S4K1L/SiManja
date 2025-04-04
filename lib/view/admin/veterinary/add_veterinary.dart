import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/veterinary_controller.dart';
import 'package:simanja/utils/theme/colors.dart';

class AddVeterinaryPage extends StatelessWidget {
  final VeterinaryController controller = Get.put(VeterinaryController());

  AddVeterinaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_new,color: kWhiteColor,)),
        backgroundColor: kAppBarColor,
        title: Text(
          'Add Veterinary',
          style: TextStyle(
            fontSize: 20.sp,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: "AvarezoSerif",
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            _buildInputField("Name", controller.nameController),
            _buildInputField("Specialization", controller.specializationController),
            _buildInputField("Contact Number", controller.contactNumberController, keyboardType: TextInputType.phone),
            _buildInputField("Location", controller.locationController),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: () {
                controller.addVeterinary();
                Get.back();
              },
              icon: const Icon(Icons.save),
              label: Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kAppBarColor,
                minimumSize: Size(double.infinity, 50.h),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }
}
