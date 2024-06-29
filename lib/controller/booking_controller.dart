// // // ignore_for_file: avoid_print

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:get/get.dart';
// // import 'package:rafael_barbershop_app/models/booking_models.dart';

// // class BookingController extends GetxController {
// //   Future<void> addBooking(BookingModel booking) async {
// //     try {
// //       await FirebaseFirestore.instance
// //           .collection("bookingan")
// //           .add(booking.toJson());
// //       print("Booking added successfully!");
// //     } catch (e) {
// //       print("Error adding booking : $e");
// //     }
// //   }
// // }

// // ignore_for_file: avoid_print, depend_on_referenced_packages, unused_import

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:rafael_barbershop_app/models/booking_models.dart';
// import 'package:rafael_barbershop_app/models/capster_models.dart';

// class BookingController extends GetxController {
//   final Rx<CapsterModels?> selectedCapster = Rx<CapsterModels?>(null);
//   final RxList<DateTime> dayList = RxList<DateTime>([]);
//   final RxList<String> timeList = RxList<String>([]);

//   @override
//   void onInit() {
//     super.onInit();
//     generateDayList();
//     generateTimeList();
//   }

//   void setSelectedCapster(CapsterModels capster) {
//     selectedCapster.value = capster;
//   }

//   void generateDayList() {
//     dayList.clear();
//     DateTime now = DateTime.now();
//     for (int i = 0; i < 7; i++) {
//       dayList.add(now.add(Duration(days: i)));
//     }
//   }

//   void generateTimeList() {
//     timeList.value = [
//       '08:00',
//       '09:00',
//       '10:00',
//       '11:00',
//       '12:00',
//       '13:00',
//       '14:00',
//       '15:00',
//       '16:00'
//     ];
//   }

//   Future<void> addBooking(BookingModel booking) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("bookingan")
//           .add(booking.toJson());
//       print("Booking added successfully!");
//     } catch (e) {
//       print("Error adding booking : $e");
//     }
//   }
// }

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rafael_barbershop_app/models/booking_models.dart';
import 'package:rafael_barbershop_app/models/capster_models.dart';

class BookingController extends GetxController {
  final Rx<CapsterModels?> selectedCapster = Rx<CapsterModels?>(null);
  final RxList<DateTime> dayList = RxList<DateTime>([]);
  final RxList<String> timeList = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();
    generateDayList();
    generateTimeList();
  }

  void setSelectedCapster(CapsterModels capster) {
    selectedCapster.value = capster;
  }

  void generateDayList() {
    dayList.clear();
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      dayList.add(now.add(Duration(days: i)));
    }
  }

  void generateTimeList() {
    timeList.value = [
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00'
    ];
  }

  Future<void> addBooking(BookingModel booking) async {
    try {
      await FirebaseFirestore.instance
          .collection("bookingan")
          .add(booking.toJson());
      print("Booking added successfully!");
    } catch (e) {
      print("Error adding booking : $e");
    }
  }

  void bookAppointment(DateTime date, String time) {
    final capster = selectedCapster.value;
    if (capster != null) {
      BookingModel booking = BookingModel(
        namaCapster: capster.namaCapster,
        imageCapster: capster.imageCapster,
        jamBooking: time,
        hariBooking: DateFormat.EEEE().format(date),
        tanggalBooking: date.day,
        bulanBooking: DateFormat.MMMM().format(date),
        tahunBooking: date.year,
      );
      addBooking(booking);
    }
  }
}
