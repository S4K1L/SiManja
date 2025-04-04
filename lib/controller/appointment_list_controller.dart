// appointment_list_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simanja/models/appointment_model.dart';

class AppointmentListController extends GetxController {
  var appointmentsList = <AppointmentModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    streamAppointments();
  }

  void streamAppointments() {
    FirebaseFirestore.instance
        .collection('appointments')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      appointmentsList.value =
          snapshot.docs.map((doc) => AppointmentModel.fromFirestore(doc)).toList();
      isLoading.value = false;
    });
  }

  Future<void> updateAppointmentStatus(String docId, String newStatus) async {
    await FirebaseFirestore.instance.collection('appointments').doc(docId).update({
      'status': newStatus,
    });
  }

  Future<void> deleteAppointment(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('appointments').doc(docId).delete();
      appointmentsList.removeWhere((appointment) => appointment.docId == docId);
      Get.snackbar("Deleted", "Appointment has been deleted successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete appointment.");
    }
  }

}
