import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class AdminLoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleAdminLogin() async {
    try {
      // Memeriksa apakah pengguna adalah admin
      var adminSnapshot = await FirebaseFirestore.instance
          .collection("admins")
          .where('email', isEqualTo: emailController.text)
          .get();

      // Jika tidak ada admin dengan email yang diberikan, hentikan proses
      if (adminSnapshot.docs.isEmpty) {
        debugPrint("Admin not found");
        return;
      }

      // Melakukan proses login dengan Firebase Authentication
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Jika proses login berhasil dan pengguna adalah admin
      if (credential.user != null) {
        // Navigasi ke halaman utama aplikasi
        emailController.clear();
        passwordController.clear();
        Get.toNamed(AppRoutes.addCapster.name);
      }
    } on FirebaseAuthException catch (exception) {
      // Menangani kesalahan autentikasi Firebase
      debugPrint(exception.code);
    } catch (error) {
      // Menangani kesalahan umum
      debugPrint("Error: $error");
    }
  }
}
