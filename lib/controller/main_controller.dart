// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/models/booking_models.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';
import 'package:flutter/material.dart';

class MainControllers extends GetxController
    with GetSingleTickerProviderStateMixin {
  var currentIndexMain = 0.obs;
  RxList<BookingModel> bookingList = <BookingModel>[].obs;

  // Navigator key for nested navigation
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void onInit() {
    super.onInit();
    fetchProfileUser();
    checkUserRole();
  }

  // index main controller
  final pages = <String>[
    AppRoutes.home.name,
    AppRoutes.myOrder.name,
    AppRoutes.profile.name,
  ];

  void changePage(int index) {
    currentIndexMain.value = index;
    print('Navigating to page: ${pages[index]}');
    navigatorKey.currentState?.pushNamed(pages[index]);
  }

  // User details
  var userEmail = ''.obs;
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var address = ''.obs;

  void fetchProfileUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userEmail.value = user.email ?? '';

        // Cek di koleksi 'customer'
        var customerSnapshot = await FirebaseFirestore.instance
            .collection("customer")
            .where('uid', isEqualTo: user.uid)
            .get();

        if (customerSnapshot.docs.isNotEmpty) {
          var customerData = customerSnapshot.docs.first.data();
          fullName.value = customerData['nama_lengkap'] ?? '';
          phoneNumber.value = customerData['nomor_handphone'] ?? '';
          address.value = customerData['alamat'] ?? '';
        } else {
          // Cek di koleksi 'admins'
          var adminSnapshot = await FirebaseFirestore.instance
              .collection("admins")
              .where('uid', isEqualTo: user.uid)
              .get();

          if (adminSnapshot.docs.isNotEmpty) {
            var adminData = adminSnapshot.docs.first.data();
            fullName.value = adminData['nama_lengkap'] ?? '';
            phoneNumber.value = adminData['nomor_handphone'] ?? '';
            address.value = adminData['alamat'] ?? '';
          }
        }
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  var userRole = 0.obs;
  var showDrawer = false.obs;
  var showMenuIcon = false.obs;

  void checkUserRole() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var adminSnapshot = await FirebaseFirestore.instance
            .collection("admins")
            .where('email', isEqualTo: user.email)
            .get();

        if (adminSnapshot.docs.isNotEmpty) {
          var adminData = adminSnapshot.docs.first.data();
          userRole.value = adminData['rule'];
          showDrawer.value = true;
          showMenuIcon.value = userRole.value == 1 || userRole.value == 2;
        } else {
          userRole.value = 0;
          showDrawer.value = false;
          showMenuIcon.value = false;
        }
      }
    } catch (e) {
      print("Error checking user role: $e");
    }
  }
}
