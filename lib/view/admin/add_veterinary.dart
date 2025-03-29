// add_veterinary_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/veterinary_controller.dart';

class AddVeterinaryPage extends StatelessWidget {
  final VeterinaryController controller = Get.put(VeterinaryController());
  AddVeterinaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Veterinary'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter name' : null,
              ),
              SizedBox(height: 10.sp),
              TextFormField(
                controller: controller.specializationController,
                decoration: const InputDecoration(labelText: 'Specialization'),
                validator: (value) => value!.isEmpty ? 'Please enter specialization' : null,
              ),
              SizedBox(height: 10.sp),
              TextFormField(
                controller: controller.contactNumberController,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter contact number' : null,
              ),
              SizedBox(height: 10.sp),
              TextFormField(
                controller: controller.locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value!.isEmpty ? 'Please enter location' : null,
              ),
              SizedBox(height: 20.sp),
              Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.addVeterinary(),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Add Veterinary'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
