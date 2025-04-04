import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simanja/models/post_model.dart';

class UpdatesPostController extends GetxController {
  var isLoading = true.obs;
  var postList = <PostModel>[].obs;

  var isUploading = false.obs;
  var selectedImage = Rxn<File>();

  final title = ''.obs;
  final description = ''.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage(File(picked.path));
    }
  }

  Future<void> uploadPost() async {
    if (title.isEmpty || description.isEmpty) {
      Get.snackbar('Missing Fields', 'Title and Description are required.');
      return;
    }

    try {
      isUploading(true);
      String? imageUrl;

      if (selectedImage.value != null) {
        final file = selectedImage.value!;
        final fileName = 'posts/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final ref = FirebaseStorage.instance.ref().child(fileName);
        await ref.putFile(file);
        imageUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('posts').add({
        'title': title.value,
        'description': description.value,
        'image': imageUrl ?? '',
        'date': Timestamp.now(),
      });

      Get.back(); // Go back to previous screen
      Get.snackbar('Success', 'Post uploaded successfully!');
      fetchPosts(); // Refresh post list after uploading
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload post');
    } finally {
      isUploading(false);
    }
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('date', descending: true)
          .get();

      postList.value = snapshot.docs.map((doc) {
        return PostModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load posts');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deletePost(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(docId).delete();
      postList.removeWhere((post) => post.id == docId);
      Get.snackbar('Deleted', 'Post has been deleted successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete post.');
    }
  }

}
