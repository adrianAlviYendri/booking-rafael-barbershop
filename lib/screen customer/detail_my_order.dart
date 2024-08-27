// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:rafael_barbershop_app/controller/my_order_controller.dart';
import 'package:rafael_barbershop_app/models/booking_models.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class DetailMyOrderScreen extends StatelessWidget {
  final BookingModel booking;

  const DetailMyOrderScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MyOrderController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(AppRoutes.main.name);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Detail My Order',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.grey[800],
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/logo_rafael.jpeg',
                  height: 150,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    children: [
                      controller.textRow(
                        'Nama Pelanggan',
                        ':  ${booking.namaPelanggan}',
                      ),
                      controller.textRow(
                        'Nama Capster',
                        ':  ${booking.namaCapster}',
                      ),
                      controller.textRow(
                        'Menu Booking',
                        ':  ${booking.menu}',
                      ),
                      controller.textRow(
                        'Jam ',
                        ':  ${booking.jamBooking}',
                      ),
                      controller.textRow(
                        'Hari ',
                        ':  ${booking.hariBooking}',
                      ),
                      controller.textRow(
                        'Tanggal ',
                        ':  ${booking.tanggalBooking}',
                      ),
                      controller.textRow(
                        'Bulan ',
                        ':  ${booking.bulanBooking}',
                      ),
                      controller.textRow(
                        'Tahun ',
                        ':  ${booking.tahunBooking}',
                      ),
                      controller.textRow(
                        'Jumlah Pembayaran',
                        ':  ${booking.harga}',
                      ),
                      controller.textRow(
                        'Status Pembookingan',
                        ':  ${booking.statusPembayaran}',
                      ),
                    ],
                  ),
                ),
              ),
              // Print Button at the Bottom
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Silahkan Print Invoice, Untuk Di bawa Ke BarBer',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final pdfData = await controller.generatePdf(booking);
                    await Printing.layoutPdf(
                        onLayout: (PdfPageFormat format) async => pdfData);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                  ),
                  child: const Text(
                    'Print',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
