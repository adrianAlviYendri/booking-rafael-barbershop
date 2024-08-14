import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rafael_barbershop_app/controller/booking_controller.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-jadwal-cuti-capster/jadwal_cuti_capster_models.dart';

class JadwalCutiCapsterController extends GetxController {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController capsterController = TextEditingController();
  DateTime? selectedDate;
  final RxList<JadwalCutiCapsterModels> nonWorkingDays =
      RxList<JadwalCutiCapsterModels>([]);
  final db = FirebaseFirestore.instance;
  var controllerBooking = Get.put(BookingController());

  @override
  void onInit() {
    super.onInit();
    controllerBooking.getJadwalCutiCapster(); // Memuat data saat inisialisasi
  }

  // Method untuk menambahkan tanggal non-working day
  Future<void> addJadwalCuti(DateTime date, String namaCapster) async {
    DocumentReference docRef = db.collection('jadwal_cuti_capster').doc();
    String uniqueId = docRef.id;
    final nonWorkingDay = JadwalCutiCapsterModels(
      idCuti: uniqueId,
      tanggalBooking: date.day, // Ambil tanggal dari objek DateTime
      bulanBooking:
          DateFormat.MMMM().format(date), // Format bulan dari objek DateTime
      tahunBooking: date.year, // Ambil tahun dari objek DateTime
      namaCapster: namaCapster, // Nama capster yang diterima sebagai parameter
    );

    await FirebaseFirestore.instance
        .collection('jadwal_cuti_capster')
        .add(nonWorkingDay.toJson());
    controllerBooking
        .getJadwalCutiCapster(); // Refresh data setelah menambahkan
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectedDate = picked;
      dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
    }
  }

  Future<void> deleteJadwal(JadwalCutiCapsterModels jadwal) async {
    try {
      final querySnapshot = await db
          .collection('jadwal_cuti_capster')
          .where('id_cuti', isEqualTo: jadwal.idCuti)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      controllerBooking.getJadwalCutiCapster(); // Refresh data
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus menu: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void showDeleteConfirmationDialogJadwalCuti(
      BuildContext context, JadwalCutiCapsterModels jadwal) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Penghapusan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_forever, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Apakah Anda yakin ingin menghapus Jadwal Cuti?',
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
              deleteJadwal(jadwal);
              Get.back(); // Close the dialog
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
