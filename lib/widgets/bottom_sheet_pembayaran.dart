// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

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
    var controllerPembayaran = Get.put(PembayaranController());
    var controllerBooking = Get.find<BookingController>();
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Menampilkan gambar yang dipilih
              Obx(
                () => controllerBooking.pickedFile.value != null
                    ? Container(
                        width: screenSize.width * 0.8,
                        height: screenSize.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            controllerBooking.pickedFile.value!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.image,
                        size: 150,
                        color: Colors.grey,
                      ),
              ),
              const SizedBox(height: 20),

              // Tombol Pilih Gambar
              AppElevetedButtonWidgets(
                onPressed: () {
                  print("Pilih image pressed");
                  controllerBooking.selectImageFile();
                },
                backgroundColor: Colors.blueAccent,
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.photo_library, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Choose Image',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Upload Gambar
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
                      Icon(Icons.upload, color: Colors.white), // Ikon upload
                      SizedBox(width: 8),
                      Text(
                        'Upload Image',
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
