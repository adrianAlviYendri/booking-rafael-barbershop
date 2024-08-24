// ignore_for_file: unnecessary_overrides, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/capster_models.dart';

class AddCapsterController extends GetxController {
  TextEditingController namaCapsterController = TextEditingController();
  var dataCapster = <CapsterModels>[].obs;
  final db = FirebaseFirestore.instance;
  final ImagePicker picker = ImagePicker();
  var pickedFile = Rx<File?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getModelPotongan();
  }

  void selectImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedFile.value = File(picked.path);
    }
  }

  void addDataCapster() async {
    if (pickedFile.value == null) return;

    try {
      final ref = FirebaseStorage.instance.ref().child(
          'image_capster/${DateTime.now().millisecondsSinceEpoch}_${pickedFile.value!.path.split('/').last}');
      final taskSnapshot = await ref.putFile(pickedFile.value!);
      final imageUrlCapster = await taskSnapshot.ref.getDownloadURL();
      print("Image uploaded successfully. URL: $imageUrlCapster");

      DocumentReference docRef = db.collection('capster').doc();
      String uniqueId = docRef.id;

      final addCapsterModels = CapsterModels(
        idCapster: uniqueId,
        namaCapster: namaCapsterController.text,
        imageCapster: imageUrlCapster,
      );
      await db.collection("capster").add(addCapsterModels.toJson());

      printInfo(info: "Capster added successfully");

      // Clear the controller and reset the picked file
      namaCapsterController.clear();
      pickedFile.value = null;
      getModelPotongan();
    } catch (e) {
      printError(info: "Error adding capster: $e");
    }
  }

  Future<void> getModelPotongan() async {
    isLoading.value = true;
    try {
      final snapshot = await db.collection('capster').get();
      dataCapster.value = snapshot.docs.map((doc) {
        final menu = CapsterModels.fromJson(doc.data());
        return menu;
      }).toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCapster(CapsterModels e) async {
    try {
      final querySnapshot = await db
          .collection('capster')
          .where('id_capster', isEqualTo: e.idCapster)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      getModelPotongan();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus Data Hair Style: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void showDeleteConfirmationCapster(BuildContext context, CapsterModels e) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Penghapusan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_forever, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Apakah Anda yakin ingin menghapus data Capster?',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              deleteCapster(e);
              Get.back();
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
