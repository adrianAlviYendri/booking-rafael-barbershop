// ignore_for_file: prefer_const_constructors, avoid_print, use_rethrow_when_possible

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rafael_barbershop_app/models/booking_models.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/capster_models.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-jadwal-cuti-capster/jadwal_cuti_capster_models.dart';

class BookingController extends GetxController {
  final Rx<CapsterModels?> selectedCapster = Rx<CapsterModels?>(null);
  final RxList<DateTime> dayList = RxList<DateTime>([]);
  final RxList<String> timeList = RxList<String>([]);

  final db = FirebaseFirestore.instance;
  final picker = ImagePicker();
  File? imageFile;
  var pickedFile = Rx<PlatformFile?>(null);

  @override
  void onInit() {
    super.onInit();
    generateDayList();
    generateTimeList();
    getJadwalCutiCapster();
  }

  bool isDateDisabled(DateTime date) {
    final capsterName = selectedCapster.value?.namaCapster;
    print("Checking date: $date for capster: $capsterName");
    bool isDisabled = jadwalCuti.any((day) =>
        day.tanggalBooking == date.day &&
        day.bulanBooking == DateFormat.MMMM().format(date) &&
        day.tahunBooking == date.year &&
        day.namaCapster == capsterName); // Tambahkan pengecekan nama capster
    print("Date $date isDisabled: $isDisabled");
    return isDisabled;
  }

  void setSelectedCapster(CapsterModels capster) {
    selectedCapster.value = capster;
  }

  CapsterModels? getSelectedCapster() {
    return selectedCapster.value;
  }

  var jadwalCuti = <JadwalCutiCapsterModels>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  Future<void> getJadwalCutiCapster() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('jadwal_cuti_capster')
          .get();
      jadwalCuti.value = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return JadwalCutiCapsterModels.fromJson(data);
      }).toList();
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Gagal memuat data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void generateDayList() async {
    await getJadwalCutiCapster(); // Memastikan non-working days sudah dimuat
    dayList.clear();
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      dayList.add(
        now.add(
          Duration(days: i),
        ),
      );
    }
  }

  void generateTimeList() {
    timeList.value = [
      '10:00',
      '10:45',
      '11:30',
      '12:45',
      '13:30',
      '14:15',
      '15:00',
      '15:45',
      '16:30',
      '17:15',
      '19:00',
      '19:45',
      '20:30',
      '21:15',
    ];
  }

  Future<Map<String, bool>> getTimeBookings(
      DateTime date, List<String> timeList) async {
    Map<String, bool> bookings = {};
    for (String time in timeList) {
      bool isBooked = await isTimeBooked(date, time);
      bookings[time] = isBooked;
    }
    return bookings;
  }

  Future<bool> isTimeBooked(DateTime date, String time) async {
    final capster = selectedCapster.value;
    if (capster == null) return false;

    final QuerySnapshot result = await db
        .collection('bookingan')
        .where('tanggal_booking', isEqualTo: date.day)
        .where('bulan_booking', isEqualTo: DateFormat.MMMM().format(date))
        .where('tahun_booking', isEqualTo: date.year)
        .where('jam_booking', isEqualTo: time)
        .where('nama_capster', isEqualTo: capster.namaCapster)
        .get();
    return result.docs.isNotEmpty;
  }

  void selectImageBuktiPembayaran() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedFile.value = result.files.first;
    }
  }

  Future<void> bookAppointment(
      DateTime date,
      String time,
      String menu,
      int harga,
      String namaPelanggan,
      String noHandphone,
      String namaCapster,
      String uid) async {
    final capster = selectedCapster.value;
    if (pickedFile.value == null) {
      print("No file selected for payment proof."); // Debug log
      return;
    }
    try {
      print("Starting file upload..."); // Debug log
      final ref = FirebaseStorage.instance
          .ref()
          .child('image_bukti_pembayaran/${pickedFile.value!.name}');
      final taskSnapshot = await ref.putFile(File(pickedFile.value!.path!));
      final imageUrlBuktiPembayaran = await taskSnapshot.ref.getDownloadURL();

      print(
          "File uploaded successfully. URL: $imageUrlBuktiPembayaran"); // Debug log

      if (capster != null) {
        debugPrint('USERRRRRRRRR ID : $uid');
        DocumentReference docRef = db.collection('bookingan').doc();
        String uniqueId = docRef.id;
        BookingModel booking = BookingModel(
          idBooking: uniqueId,
          userId: uid,
          namaCapster: namaCapster,
          imageCapster: capster.imageCapster,
          namaPelanggan: namaPelanggan,
          noHandphone: noHandphone,
          jamBooking: time,
          hariBooking: DateFormat.EEEE().format(date),
          tanggalBooking: date.day,
          bulanBooking: DateFormat.MMMM().format(date),
          tahunBooking: date.year,
          buktiPembayaran: imageUrlBuktiPembayaran,
          menu: menu,
          harga: harga,
          statusPembayaran: 'Pending',
        );
        await db.collection('bookingan').doc(uniqueId).set(booking.toJson());
        print("Booking added successfully to Firestore."); // Debug log
      }
    } catch (e) {
      print("Error during booking: $e"); // Debug log
      throw e;
    }
  }
}
