import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-metode-pembayaran/metode_pembayaran_models.dart';

class MetodePembayaranController extends GetxController {
  TextEditingController jenisMetodeController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  var dataPembayaran = <MetodePembayaranModels>[].obs;
  final db = FirebaseFirestore.instance;
  final picker = ImagePicker();
  File? imageFile;
  var pickedFile = Rx<PlatformFile?>(null);

  @override
  void onInit() {
    super.onInit();
    getMetodePembayaran();
  }

  void selectImageMetode() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedFile.value = result.files.first;
    }
  }

  void addMetodePembayaran() async {
    if (pickedFile.value == null) return;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('image_metode_pembayaran/${pickedFile.value!.name}');
      final taskSnapshot = await ref.putFile(File(pickedFile.value!.path!));
      final imageUrlPembayaran = await taskSnapshot.ref.getDownloadURL();
      DocumentReference docRef = db.collection('metode_pembayaran').doc();
      String uniqueId = docRef.id;
      final addPembayaranModels = MetodePembayaranModels(
        idMetode: uniqueId,
        imageQr: imageUrlPembayaran,
        jenisMetode: jenisMetodeController.text,
        keterangan: keteranganController.text,
      );
      await db
          .collection("metode_pembayaran")
          .add(addPembayaranModels.toJson());

      printInfo(info: "METODE PEMBAYARAN added successfully");

      // Clear the controller and reset the picked file
      jenisMetodeController.clear();
      keteranganController.clear();
      pickedFile.value = null;
      getMetodePembayaran();
    } catch (e) {
      printError(info: "Error adding METODE PEMBAYARAN: $e");
    }
  }

  var isLoading = false.obs;
  Future<void> getMetodePembayaran() async {
    isLoading.value = true;
    try {
      final snapshot = await db.collection('metode_pembayaran').get();
      dataPembayaran.value = snapshot.docs.map((doc) {
        final metodePembayaran = MetodePembayaranModels.fromJson(doc.data());
        return metodePembayaran;
      }).toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteMetode(MetodePembayaranModels e) async {
    try {
      final querySnapshot = await db
          .collection('metode_pembayaran')
          .where('id_metode', isEqualTo: e.idMetode)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      getMetodePembayaran();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus Data Metode Pembayaran: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void showDeleteConfirmationMetode(
      BuildContext context, MetodePembayaranModels e) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Penghapusan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_forever, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Apakah Anda yakin ingin menghapus data Metode Pembayaran?',
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
              deleteMetode(e);
              Get.back();
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
