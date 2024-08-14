// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/controller/booking_controller.dart';
import 'package:rafael_barbershop_app/controller/pembayaran_controller.dart';

class BottomSheetPembayaran extends StatelessWidget {
  final DateTime date;
  final String time;
  final String menu;
  final int harga;
  final String namaPelanggan;
  final String noHandphone;
  final String namaCapster;
  final String uid;

  const BottomSheetPembayaran({
    required this.date,
    required this.time,
    required this.menu,
    required this.harga,
    required this.namaPelanggan,
    required this.noHandphone,
    required this.namaCapster,
    required this.uid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controllerBooking = Get.find<BookingController>();
    var controllerPembayaran = Get.put(PembayaranController());
    final screenSize = MediaQuery.of(context).size;

    print("Building BottomSheetPembayaran");

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => controllerBooking.pickedFile.value != null &&
                        controllerBooking.pickedFile.value!.path != null
                    ? Container(
                        width: screenSize.width * 0.8,
                        height: screenSize.height * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.file(
                            File(controllerBooking.pickedFile.value!.path!),
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.payments_outlined,
                        size: 150,
                      ),
              ),
              const SizedBox(height: 20),
              AppElevetedButtonWidgets(
                onPressed: () {
                  print("Pilih Bukti Pembayaran pressed");
                  controllerBooking.selectImageBuktiPembayaran();
                },
                backgroundColor: Colors.blueAccent, // Warna biru
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.photo_library,
                        color: Colors.white), // Ikon galeri
                    SizedBox(width: 8),
                    Text(
                      'Choose File ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return AppElevetedButtonWidgets(
                  onPressed: controllerBooking.pickedFile.value != null
                      ? () async {
                          print(
                              "Upload button pressed with date: $date and time: $time");
                          try {
                            Get.back();
                            controllerPembayaran.onBookingSuccess(
                                date,
                                time,
                                menu,
                                harga,
                                namaPelanggan,
                                noHandphone,
                                namaCapster,
                                uid);
                          } catch (e) {
                            print("Error during booking: $e");
                            Get.snackbar(
                              'Error',
                              'Gagal membuat booking. Silakan coba lagi.',
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        }
                      : null,
                  backgroundColor: Colors.green, // Warna hijau
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, color: Colors.white), // Ikon centang
                      SizedBox(width: 8),
                      Text(
                        'Send File',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
