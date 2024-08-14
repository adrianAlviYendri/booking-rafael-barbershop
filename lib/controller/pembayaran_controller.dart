// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/controller/booking_controller.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class PembayaranController extends GetxController {
  var controllerBooking = Get.put(BookingController());
  void onBookingSuccess(
      date, time, menu, harga, namaPelanggan, noHandphone, namaCapster, uid) {
    // Menampilkan dialog konfirmasi
    showDialog(
      context: Get.context!,
      barrierDismissible: false, // Mencegah menutup dialog dengan tap di luar
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Konfirmasi Booking",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tanggal: ${DateFormat('dd MMMM yyyy').format(date)}",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              Text(
                "Waktu: $time",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              Text(
                "Menu: $menu",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              Text(
                "Harga: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(harga)}",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 10),
              Text(
                "Nama: $namaPelanggan",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              Text(
                "No. HP: $noHandphone",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              Text(
                "Capster: $namaCapster",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppElevetedButtonWidgets(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: Colors.green,
                  onPressed: () {
                    controllerBooking.bookAppointment(date, time, menu, harga,
                        namaPelanggan, noHandphone, namaCapster, uid);
                    print("Oke button clicked, navigating to main page...");
                    Future.delayed(const Duration(seconds: 2), () {
                      Get.offAllNamed(AppRoutes.main.name);
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.check, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Ya",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                AppElevetedButtonWidgets(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: Colors.red,
                  onPressed: () {
                    Get.back(); // Kembali ke dialog sebelumnya
                  },
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Tidak",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
