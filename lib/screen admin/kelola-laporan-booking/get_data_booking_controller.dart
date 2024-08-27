// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/models/booking_models.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class GetDataBookingController extends GetxController {
  final db = FirebaseFirestore.instance;
  var dataBooking = RxList<BookingModel>();
  var isLoading = false.obs;
  RxDouble totalRevenuePerDay = 0.0.obs;
  RxDouble totalRevenuePerMonth = 0.0.obs;
  RxDouble totalRevenuePerYear = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getDataBooking();
  }

  void calculateTotalRevenuePerDay() {
    double total = 0.0;
    for (var booking in dataBooking) {
      total += booking.harga ?? 0.0;
    }
    totalRevenuePerDay.value = total;
  }

  void calculateTotalRevenuePerMonth() {
    double total = 0.0;
    for (var booking in dataBooking) {
      total += booking.harga ?? 0.0;
    }
    totalRevenuePerMonth.value = total;
  }

  void calculateTotalRevenuePerYear() {
    double total = 0.0;
    for (var booking in dataBooking) {
      total += booking.harga ?? 0.0;
    }
    totalRevenuePerYear.value = total;
  }

  void getDataBooking({int? day, int? month, int? year}) async {
    isLoading.value = true; // Start loading
    try {
      Query query = db.collection("bookingan");

      if (day != null) {
        query = query.where("tanggal_booking", isEqualTo: day);
      }
      if (month != null) {
        String monthName = DateFormat.MMMM().format(DateTime(0, month));
        query = query.where("bulan_booking", isEqualTo: monthName);
      }
      if (year != null) {
        query = query.where("tahun_booking", isEqualTo: year);
      }

      var getDataBooking = await query.get();
      dataBooking.clear();
      for (var doc in getDataBooking.docs) {
        var bookingData = doc.data() as Map<String, dynamic>;
        dataBooking.add(BookingModel.fromJson(bookingData));
      }
      if (day != null) {
        calculateTotalRevenuePerDay();
      } else if (month != null) {
        calculateTotalRevenuePerMonth();
      } else if (year != null) {
        calculateTotalRevenuePerYear();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat Data Booking: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false; // End loading
    }
  }

  Future<void> deleteBooking(BookingModel e) async {
    try {
      final querySnapshot = await db
          .collection('bookingan')
          .where('id_booking', isEqualTo: e.idBooking)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      getDataBooking(); // Refresh data
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus Data Booking: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updatePaymentStatus(String bookingId, String status) async {
    try {
      var docRef =
          FirebaseFirestore.instance.collection('bookingan').doc(bookingId);
      var docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        Get.snackbar('Error', 'Dokumen dengan ID $bookingId tidak ditemukan.');
        return;
      }

      // Perbarui status pembayaran
      await docRef.update({'status_pembayaran': status});
      // Get.snackbar('Success', 'Status pembayaran diperbarui menjadi $status.');
      getDataBooking();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui status pembayaran: $e');
    }
  }

  void showUpdatePaymentStatusDialog(BuildContext context, String idBooking) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Pembayaran'),
        content: const Text(
            'Apakah Anda yakin ingin mengubah status pembayaran menjadi Success?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Menutup dialog
            },
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Warna tombol Yes
            ),
            onPressed: () {
              if (idBooking != null) {
                updatePaymentStatus(idBooking, 'Success');
              }
              Get.back(); // Menutup dialog
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  void showDeleteConfirmationBooking(BuildContext context, BookingModel e) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Penghapusan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_forever, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Apakah Anda yakin ingin menghapus data booking?',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red, // Text color
            ),
            onPressed: () {
              deleteBooking(e);
              Get.back(); // Close the dialog
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> generatePdf(List<BookingModel> bookings,
      RxDouble totalPendapatan, String keterangan) async {
    final pdf = pw.Document();

    // Load the images as bytes
    final Uint8List logoBytes = await rootBundle
        .load('assets/images/logo_rafael.jpeg')
        .then((byteData) => byteData.buffer.asUint8List());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header with logos
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(pw.MemoryImage(logoBytes),
                        height: 60), // Display the main logo
                    pw.Text(
                      'Laporan Booking Per $keterangan',
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
                // Location and contact info
                pw.Text(
                  'Jl. Sutan Syahrir, Painan, Kec. Iv Jurai, Kabupaten Pesisir Selatan, Sumatera Barat',
                  style: pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Total Pendapatan Per $keterangan: Rp.${totalPendapatan.toStringAsFixed(2)}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                // Booking Details Table
                pw.Table.fromTextArray(
                  headers: [
                    'No',
                    'Nama Capster',
                    'Nama Pelanggan',
                    'Jam Booking',
                    'Tanggal Booking',
                    'Bulan Booking',
                    'Tahun Booking',
                    'Menu',
                    'Jumlah Pembayaran',
                  ],
                  data: List.generate(bookings.length, (index) {
                    final booking = bookings[index];
                    return [
                      (index + 1).toString(),
                      booking.namaCapster ?? '',
                      booking.namaPelanggan ?? '',
                      booking.jamBooking ?? '',
                      booking.tanggalBooking.toString(),
                      booking.bulanBooking ?? '',
                      booking.tahunBooking.toString(),
                      booking.menu ?? '',
                      booking.harga.toString(),
                    ];
                  }),
                ),
                pw.SizedBox(height: 20),
                pw.Divider(height: 2),
                pw.SizedBox(height: 20),
                // Signature section
                pw.Text(
                  'Tanda Tangan Pemilik',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 70), // Space for signature
                pw.Text(
                  '(____________________________)',
                  style: pw.TextStyle(
                    fontSize: 16,
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

  void buktiPaymentDialog(BuildContext context, String imageUrl) {
    final screenSize = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: screenSize.width * 0.8, // Atur lebar dialog sesuai kebutuhan
            height:
                screenSize.height * 0.6, // Atur tinggi dialog sesuai kebutuhan
            child: Image.network(
              imageUrl,
              fit: BoxFit
                  .contain, // Atur konten gambar agar sesuai dengan ukuran
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                              (progress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Text('Error loading image'),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
