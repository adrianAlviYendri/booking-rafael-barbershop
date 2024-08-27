import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/controller/main_controller.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mainController = Get.put(MainControllers());

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[800],
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Header
            CircleAvatar(
              radius: 50, // Size of the profile image
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(() => Text(
                  mainController.fullName.value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )),
            const SizedBox(
              height: 8,
            ),
            Obx(() => Text(
                  mainController.userEmail.value,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textProfileInfoRow(
                        'No Handphone:', mainController.phoneNumber.value),
                    textProfileInfoRow('Alamat:', mainController.address.value),
                  ],
                ),
              ),
            ),
            const Spacer(),
            AppElevetedButtonWidgets(
              onPressed: () {
                showConfirmationLogOut();
              },
              elevation: 0,
              borderRadius: BorderRadius.circular(30),
              backgroundColor: Colors.grey[800],
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textProfileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showConfirmationLogOut() {
    Get.dialog(
      AlertDialog(
        title: const Text('Apakah Anda yakin ingin Log Out?'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout, size: 50, color: Colors.red),
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
              backgroundColor: Colors.red, // Text color
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAllNamed(AppRoutes.login.name);
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
