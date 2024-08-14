import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/capster_controller.dart';

class BottomSheetAddCapster extends StatelessWidget {
  const BottomSheetAddCapster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddCapsterController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      child: Column(
        children: [
          Obx(() => controller.pickedFile.value != null &&
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
              : IconButton(
                  onPressed: () {
                    controller.selectImage();
                  },
                  icon: const Icon(
                    Icons.add_a_photo_outlined,
                    size: 150,
                  ),
                )),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: controller.namaCapsterController,
            decoration: InputDecoration(
              labelText: 'add name capster',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AppElevetedButtonWidgets(
            onPressed: () {
              controller.addDataCapster();
              Get.back();
            },
            elevation: 10,
            borderRadius: BorderRadius.circular(30),
            backgroundColor: Colors.blueGrey,
            shadowColor: Colors.black,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
