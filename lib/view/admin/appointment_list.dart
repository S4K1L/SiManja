import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/controller/appointment_list_controller.dart';
import 'package:simanja/utils/theme/colors.dart';

class AppointmentListPage extends StatelessWidget {
  final AppointmentListController controller = Get.put(AppointmentListController());

  AppointmentListPage({super.key});

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
          'Appointments',
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

        final pending = controller.appointmentsList.where((a) => a.status == 'Pending').toList();
        final confirmed = controller.appointmentsList.where((a) => a.status == 'Confirmed').toList();
        final canceled = controller.appointmentsList.where((a) => a.status == 'Canceled').toList();

        return ListView(
          children: [
            _buildStatusSection("Pending", pending, Colors.orange),
            _buildStatusSection("Confirmed", confirmed, Colors.green),
            _buildStatusSection("Canceled", canceled, Colors.red),
          ],
        );
      }),
    );
  }

  Widget _buildStatusSection(String title, List appointments, Color color) {
    return ExpansionTile(
      title: Text(
        "$title (${appointments.length})",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      initiallyExpanded: true,
      children: appointments.map<Widget>((appointment) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 3,
            color: Colors.grey[50],
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _info("Owner", appointment.ownerName),
                  _info("Pet Name", appointment.petName),
                  _info("Date", appointment.appointmentDate),
                  _info("Contact", appointment.contactNumber),
                  _info("Reason", appointment.reason),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: Get.context!,
                          builder: (_) => CupertinoActionSheet(
                            title: const Text('Change Status'),
                            actions: ['Pending', 'Confirmed', 'Canceled'].map((status) {
                              return CupertinoActionSheetAction(
                                onPressed: () async {
                                  controller.updateAppointmentStatus(appointment.docId, status);
                                  Get.back();
                                },
                                child: Text(status),
                              );
                            }).toList(),
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () => Get.back(),
                              isDefaultAction: true,
                              child: const Text('Cancel'),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              appointment.status ?? 'Pending',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        "$label: $value",
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}
