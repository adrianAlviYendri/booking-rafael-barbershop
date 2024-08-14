import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-hair-color/hair_color_models.dart';

class HairColorController extends GetxController {
  TextEditingController namaHairColorController = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  var dataHairColor = <HairColorModels>[].obs;
  var pickedFile = Rx<PlatformFile?>(null);
  final picker = FilePicker.platform;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getHairColor();
  }

  // Method to select an image from file picker
  void selectImageHairColor() async {
    final result = await picker.pickFiles();
    if (result != null) {
      pickedFile.value = result.files.first;
    }
  }

  void addHairColor() async {
    if (pickedFile.value == null) return;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('image_hair_color/${pickedFile.value!.name}');
      final taskSnapshot = await ref.putFile(File(pickedFile.value!.path!));
      final imageUrlHairColor = await taskSnapshot.ref.getDownloadURL();
      DocumentReference docRef = db.collection('warna_rambut').doc();
      String uniqueId = docRef.id;

      final addHairColorModels = HairColorModels(
        idHairColor: uniqueId,
        namaHairColor: namaHairColorController.text,
        imageHairColor: imageUrlHairColor,
      );
      await db.collection("warna_rambut").add(addHairColorModels.toJson());

      printInfo(info: "Hair Color added successfully");

      namaHairColorController.clear();
      pickedFile.value = null;
      getHairColor();
    } catch (e) {
      printError(info: "Error adding Hair Color: $e");
    }
  }

  Future<void> getHairColor() async {
    isLoading.value = true;
    try {
      final snapshot = await db.collection('warna_rambut').get();
      dataHairColor.value = snapshot.docs.map((doc) {
        final hairColor = HairColorModels.fromJson(doc.data());
        return hairColor;
      }).toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteHairColor(HairColorModels hairColor) async {
    try {
      final querySnapshot = await db
          .collection('warna_rambut')
          .where('id_hair_color', isEqualTo: hairColor.idHairColor)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      getHairColor();
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

  void showDeleteConfirmationHairColor(
      BuildContext context, HairColorModels hairColor) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Penghapusan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_forever, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Apakah Anda yakin ingin menghapus data Hair Color?',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              deleteHairColor(hairColor);
              Get.back();
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
