import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleRegister() async {
    try {
      var cradential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      var user = FirebaseFirestore.instance.collection("customer");

      if (cradential.user != null) {
        user
            .add({'uid': cradential.user?.uid, 'email': cradential.user?.email})
            .then((value) => debugPrint("user added"))
            .catchError((error) => debugPrint("failed to add user : $error"));
      }
      emailController.clear();
      passwordController.clear();
      Get.toNamed(AppRoutes.login.name);
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.code);
    }
  }
}
