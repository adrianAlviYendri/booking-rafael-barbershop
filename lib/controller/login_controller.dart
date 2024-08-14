import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var userRole = 0.obs;
  RxString userEmail =
      ''.obs; // Gunakan RxString untuk membuat variabel yang dapat diobservasi

  void handleLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Ambil data admin berdasarkan email dari Firestore
      var adminSnapshot = await FirebaseFirestore.instance
          .collection("admins")
          .where('email', isEqualTo: emailController.text)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        var adminData = adminSnapshot.docs.first.data();
        var rule = adminData['rule'];
        userRole.value = rule;

        if (rule == 1) {
          Get.toNamed(AppRoutes.main.name);
          Get.snackbar(
            "LOGIN SUCCESS",
            "Selamat Datang Admin",
            backgroundColor: Colors.green,
          );
        } else if (rule == 2) {
          Get.toNamed(AppRoutes.main.name);
          Get.snackbar(
            "LOGIN SUCCESS",
            "Selamat Datang Kasir",
            backgroundColor: Colors.green,
          );
        }
      } else {
        // Jika email tidak ditemukan dalam koleksi admins, arahkan ke halaman utama
        Get.toNamed(AppRoutes.main.name);
        debugPrint("CUSTOMER BERHASIL LOGIN");
        Get.snackbar(
          "LOGIN SUCCESS",
          "Silahkan Pilih Capster Yang Anda Inginkan",
          backgroundColor: Colors.green,
        );
      }

      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.code);
      emailController.clear();
      passwordController.clear();
      Get.snackbar("LOGIN GAGAL",
          "Masukan Email Dan Kata Sandi Yang Benar, Jika Belum Memiliki Akun Silahkan Register Terlebih Dahulu");
    }
  }
}
