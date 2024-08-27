// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/controller/booking_controller.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-jadwal-cuti-capster/bottom_sheet_add_jadwal_cuti.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-jadwal-cuti-capster/jadwal_cuti_capster_controller.dart';

class KelolaJadwalCutiScreen extends StatelessWidget {
  KelolaJadwalCutiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controllerBooking = Get.put(BookingController());
    final JadwalCutiCapsterController controller =
        Get.put(JadwalCutiCapsterController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Kelola Jadwal Cuti',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(
        () {
          if (controllerBooking.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controllerBooking.errorMessage.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  controllerBooking.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          } else if (controllerBooking.jadwalCuti.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tidak ada data',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: controllerBooking.jadwalCuti.length,
              itemBuilder: (context, index) {
                final jadwal = controllerBooking.jadwalCuti[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.calendar_today, color: Colors.blueGrey),
                    title: Text(
                      'Capster: ${jadwal.namaCapster}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Tanggal: ${jadwal.tanggalBooking} ${jadwal.bulanBooking} ${jadwal.tahunBooking}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.showDeleteConfirmationDialogJadwalCuti(
                            context, jadwal);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const BottomSheetAddJadwalCuti(); // Remove const if needed
            },
          );
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
    );
  }
}
