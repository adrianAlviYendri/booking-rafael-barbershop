import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleLogin() async {
    try {
      var cradential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (cradential.user != null) {
        Get.toNamed(AppRoutes.main.name);
      }
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.code);
    }
  }
}
