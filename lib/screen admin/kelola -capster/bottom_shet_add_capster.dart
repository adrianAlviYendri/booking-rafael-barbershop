import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/capster_controller.dart';

class BottomSheetAddCapster extends StatelessWidget {
  const BottomSheetAddCapster({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddCapsterController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tambah Capster',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Obx(() => controller.pickedFile.value != null
              ? Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.file(
                      controller.pickedFile.value!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Center(
                  child: IconButton(
                    onPressed: () {
                      controller.selectImage();
                    },
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 100,
                      color: Colors.blueGrey,
                    ),
                  ),
                )),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.namaCapsterController,
            decoration: InputDecoration(
              labelText: 'Nama Capster',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: AppElevetedButtonWidgets(
              onPressed: () {
                controller.addDataCapster();
                Get.back();
              },
              elevation: 10,
              borderRadius: BorderRadius.circular(12.0),
              backgroundColor: Colors.blueGrey,
              shadowColor: Colors.black,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
