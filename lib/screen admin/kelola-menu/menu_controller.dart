import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-menu/menu_models.dart';

class SelectMenuController extends GetxController {
  final namaMenuController = TextEditingController();
  final hargaController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  var dataMenu = <MenuModels>[].obs;
  var selectedMenu = Rx<String?>(null);
  var hargaMenu = Rx<int?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDataMenu();
  }

  Future<void> addDataMenu() async {
    try {
      final harga = int.tryParse(hargaController.text);
      final newMenu = MenuModels(
        namaMenu: namaMenuController.text,
        harga: harga,
      );

      await _db.collection('menu').add(newMenu.toJson());
      namaMenuController.clear();
      hargaController.clear();

      Get.snackbar(
        'Menu Berhasil Ditambahkan',
        '',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      getDataMenu(); // Refresh data
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menambahkan menu: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> getDataMenu() async {
    isLoading.value = true;
    try {
      final snapshot = await _db.collection('menu').get();
      dataMenu.value = snapshot.docs.map((doc) {
        final menu = MenuModels.fromJson(doc.data());
        return menu;
      }).toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteMenu(MenuModels menu) async {
    try {
      final querySnapshot = await _db
          .collection('menu')
          .where('nama_menu', isEqualTo: menu.namaMenu)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      getDataMenu(); // Refresh data
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus menu: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
