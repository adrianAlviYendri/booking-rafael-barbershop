import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-jadwal-cuti-capster/jadwal_cuti_capster_controller.dart';

class BottomSheetAddJadwalCuti extends StatelessWidget {
  const BottomSheetAddJadwalCuti({super.key});

  @override
  Widget build(BuildContext context) {
    final JadwalCutiCapsterController controller =
        Get.put(JadwalCutiCapsterController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tambah Jadwal Cuti Capster',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.dateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Tanggal',
              hintText: 'Pilih tanggal',
              prefixIcon: const Icon(Icons.calendar_today),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: () => controller.selectDate(context),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.capsterController,
            decoration: InputDecoration(
              labelText: 'Nama Capster',
              hintText: 'Masukkan nama capster',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (controller.selectedDate != null &&
                  controller.capsterController.text.isNotEmpty) {
                controller.addJadwalCuti(controller.selectedDate!,
                    controller.capsterController.text);
                Get.snackbar('Berhasil', 'Non-Working Day ditambahkan',
                    backgroundColor: Colors.greenAccent,
                    snackPosition: SnackPosition.BOTTOM);
                controller.dateController.clear();
                controller.capsterController.clear();
                controller.selectedDate = null;
              } else {
                Get.snackbar(
                    'Error', 'Silakan pilih tanggal dan masukkan nama capster',
                    backgroundColor: Colors.redAccent,
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: const Text('Tambahkan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
