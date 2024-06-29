import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/controller%20admin/add_model_potongan_controller.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';
// import 'package:rafael_barbershop_app/routers/app_routes.dart';

class AddCapsterScreen extends StatelessWidget {
  const AddCapsterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AddCapsterController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => controller.pickedFile.value != null &&
                            controller.pickedFile.value!.path != null
                        ? Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Image.file(
                                File(controller.pickedFile.value!.path!),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.add_a_photo_outlined,
                            size: 150,
                          ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: controller.namaCapsterController,
                    decoration: InputDecoration(
                      labelText: 'add name capster',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AppElevetedButtonWidgets(
                    onPressed: () {
                      controller.selectImage();
                    },
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    backgroundColor: Colors.blueGrey,
                    shadowColor: Colors.black,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        'Select images',
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppElevetedButtonWidgets(
                    onPressed: () {
                      controller.uploadImageAndAddCapster();
                    },
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    backgroundColor: Colors.blueGrey,
                    shadowColor: Colors.black,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        'Upload',
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: AppElevetedButtonWidgets(
                onPressed: () {
                  Get.toNamed(AppRoutes.loginAdmin.name);
                },
                elevation: 10,
                borderRadius: BorderRadius.circular(30),
                backgroundColor: Colors.black,
                shadowColor: Colors.grey,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
