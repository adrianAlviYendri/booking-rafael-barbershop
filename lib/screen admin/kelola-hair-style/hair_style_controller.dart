// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-hair-style/hair_style_models.dart';

class HairStyleController extends GetxController {
  TextEditingController namaHairStyleController = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  var dataHairStyles = <HairStyleModels>[].obs;
  final ImagePicker picker = ImagePicker();
  var pickedFile = Rx<File?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getHairStyle();
  }

  // Method to select an image from file picker
  void selectImageHairStyle() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedFile.value = File(picked.path);
    }
  }

  void addHairStyle() async {
    if (pickedFile.value == null) return;

    try {
      final ref = FirebaseStorage.instance.ref().child(
          'image_hair_style/${DateTime.now().millisecondsSinceEpoch}_${pickedFile.value!.path.split('/').last}');
      final taskSnapshot = await ref.putFile(pickedFile.value!);
      final imageUrlHairStyle = await taskSnapshot.ref.getDownloadURL();
      print("Image uploaded successfully. URL: $imageUrlHairStyle");
      DocumentReference docRef = db.collection('gaya_rambut').doc();
      String uniqueId = docRef.id;

      final addHairColorModels = HairStyleModels(
        idHairStyle: uniqueId,
        namaHairStyle: namaHairStyleController.text,
        imageHairStyle: imageUrlHairStyle,
      );
      await db.collection("gaya_rambut").add(addHairColorModels.toJson());

      printInfo(info: "Hair Style added successfully");

      namaHairStyleController.clear();
      pickedFile.value = null;
      getHairStyle();
    } catch (e) {
      printError(info: "Error adding Hair Style: $e");
    }
  }

  Future<void> getHairStyle() async {
    isLoading.value = true;
    try {
      final snapshot = await db.collection('gaya_rambut').get();
      dataHairStyles.value = snapshot.docs.map((doc) {
        final hairStyle = HairStyleModels.fromJson(doc.data());
        return hairStyle;
      }).toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteHairStyle(HairStyleModels hairStyle) async {
    try {
      final querySnapshot = await db
          .collection('gaya_rambut')
          .where('id_hair_style', isEqualTo: hairStyle.idHairStyle)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      getHairStyle();
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

  void showDeleteConfirmationHairStyle(
      BuildContext context, HairStyleModels hairStyle) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Penghapusan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_forever, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Apakah Anda yakin ingin menghapus data Hair Style?',
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
              deleteHairStyle(hairStyle);
              Get.back();
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
