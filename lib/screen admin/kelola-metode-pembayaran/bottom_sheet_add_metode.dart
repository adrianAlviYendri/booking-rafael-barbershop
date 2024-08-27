import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-metode-pembayaran/metode_pembayaran_controller.dart';

class BottomSheetAddMetode extends StatelessWidget {
  const BottomSheetAddMetode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MetodePembayaranController());

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 50,
          ),
          // Header with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tambah Metode Pembayaran',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 30),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Image selection or preview
          Obx(() => controller.pickedFile.value != null
              ? Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      controller.pickedFile.value!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    controller.selectImageMetode();
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 80,
                      color: Colors.grey[600],
                    ),
                  ),
                )),
          const SizedBox(height: 20),
          // Input field for hairstyle name
          TextFormField(
            controller: controller.jenisMetodeController,
            decoration: InputDecoration(
              labelText: 'Jenis Metode Pembayaran',
              prefixIcon: const Icon(Icons.edit, color: Colors.blueGrey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.blueGrey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Input field for hairstyle name
          TextFormField(
            controller: controller.keteranganController,
            decoration: InputDecoration(
              labelText: 'Keterangan',
              prefixIcon: const Icon(Icons.edit, color: Colors.blueGrey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.blueGrey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Save button
          AppElevetedButtonWidgets(
            onPressed: () {
              controller.addMetodePembayaran();
              Get.back();
            },
            elevation: 10,
            borderRadius: BorderRadius.circular(15),
            backgroundColor: Colors.blueGrey,
            shadowColor: Colors.black,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                'Simpan',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
