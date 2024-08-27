// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/models/booking_models.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class MyOrderController extends GetxController {
  RxList<BookingModel> bookingList = <BookingModel>[].obs;

  // Navigator key for nested navigation

  @override
  void onInit() {
    super.onInit();
    fetchBookingsMyorder();
  }

  Widget textRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? '',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget textPdfRow(String label, String titikDua, String? value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            titikDua,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            value ?? '',
            textAlign: pw.TextAlign.right,
            style: const pw.TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Future<Uint8List> generatePdf(BookingModel booking) async {
    final pdf = pw.Document();

    // Load the image as bytes
    final Uint8List logoBytes = await rootBundle
        .load('assets/images/logo_rafael.jpeg')
        .then((byteData) => byteData.buffer.asUint8List());

    // Generate a unique invoice code
    final invoiceCode = DateFormat('yyyyMMddHHmmss').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header with logo
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(pw.MemoryImage(logoBytes),
                        height: 60), // Display the image
                    pw.Text(
                      'Invoice',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 16),
                pw.Divider(),
                pw.SizedBox(height: 16),
                // Invoice Code
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Invoice Code: $invoiceCode',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Date: ${DateFormat('dd MMMM yyyy').format(DateTime.now())}',
                      style: const pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 16),
                pw.Divider(),
                pw.SizedBox(height: 16),
                // Booking Details
                textPdfRow('Nama Pelanggan', ':', '  ${booking.namaPelanggan}'),
                textPdfRow('Nama Capster', ':', '  ${booking.namaCapster}'),
                textPdfRow('Menu Booking', ':', '  ${booking.menu}'),
                textPdfRow('Jam Booking', ':', '  ${booking.jamBooking}'),
                textPdfRow('Hari Booking', ':', '  ${booking.hariBooking}'),
                textPdfRow(
                    'Tanggal Booking', ':', '  ${booking.tanggalBooking}'),
                textPdfRow('Bulan Booking', ':', '  ${booking.bulanBooking}'),
                textPdfRow('Tahun Booking', ':', '  ${booking.tahunBooking}'),
                textPdfRow('Jumlah Pembayaran', ':', '  ${booking.harga}'),
                textPdfRow('Status Pembookingan', ':',
                    '  ${booking.statusPembayaran}'),
                pw.SizedBox(height: 16),
                pw.Divider(),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Thank you for your booking!',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<List<BookingModel>> fetchBookingsMyorder() async {
    try {
      var userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        print('User ID is null');
        return []; // Mengembalikan list kosong jika userId null
      }
      print('Fetching bookings for user ID: $userId');

      var snapshot = await FirebaseFirestore.instance
          .collection('bookingan')
          .where('user_id', isEqualTo: userId)
          .get();

      List<BookingModel> bookingList = [];

      if (snapshot.docs.isEmpty) {
        print('No bookings found for user ID: $userId');
      } else {
        for (var doc in snapshot.docs) {
          var data = doc.data();
          print('Booking data: $data');
          var booking = BookingModel(
            userId: data['user_id'],
            namaPelanggan: data['nama_pelanggan'],
            noHandphone: data['no_handphone'],
            namaCapster: data['nama_capster'],
            jamBooking: data['jam_booking'],
            hariBooking: data['hari_booking'],
            tanggalBooking: data['tanggal_booking'],
            bulanBooking: data['bulan_booking'],
            tahunBooking: data['tahun_booking'],
            menu: data['nama_menu'],
            harga: data['harga'],
            statusPembayaran: data['status_pembayaran'],
          );
          bookingList.add(booking);
        }
      }
      return bookingList;
    } catch (e) {
      print('Error fetching bookings: $e');
      return []; // Mengembalikan list kosong jika terjadi error
    }
  }
}
