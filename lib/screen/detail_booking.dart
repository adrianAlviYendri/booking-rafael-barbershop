// // // ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, must_be_immutable

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:intl/intl.dart';
// // import 'package:rafael_barbershop_app/component/date_time_services_widgets.dart';
// // import 'package:rafael_barbershop_app/controller/booking_controller.dart';
// // import 'package:rafael_barbershop_app/models/booking_models.dart';
// // import 'package:rafael_barbershop_app/models/capster_models.dart';

// // class DetailBooking extends StatelessWidget {
// //   final DateTime date;
// //   final List<String> timeList =
// //       DateTimeService.timeList; // Gunakan DateTimeService
// //   var controller = Get.put(BookingController());
// //   final CapsterModels capster;

// //   DetailBooking({Key? key, required this.date, required this.capster})
// //       : super(key: key);

// //   void bookAppointment(String time) {
// //     BookingModel booking = BookingModel(
// //       namaCapster: capster.namaCapster,
// //       imageCapster: capster.imageCapster,
// //       jamBooking: time,
// //       hariBooking: DateFormat.EEEE().format(date),
// //       tanggalBooking: date.day,
// //       bulanBooking: DateFormat.MMMM().format(date),
// //       tahunBooking: date.year,
// //     );
// //     controller.addBooking(booking);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title:
// //             Text('Detail Capster - ${DateFormat('d MMMM yyyy').format(date)}'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               DateFormat.EEEE().format(date),
// //               style:
// //                   const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(height: 8.0),
// //             Text(
// //               DateFormat('d MMMM yyyy').format(date),
// //               style: TextStyle(fontSize: 16.0),
// //             ),
// //             SizedBox(height: 16.0),
// //             Wrap(
// //               spacing: 8.0,
// //               runSpacing: 8.0,
// //               children: timeList.map((time) {
// //                 return InkWell(
// //                   onTap: () => bookAppointment(time),
// //                   child: Chip(
// //                     label: Text(time),
// //                     backgroundColor: Colors.blue,
// //                     labelStyle: TextStyle(color: Colors.white),
// //                   ),
// //                 );
// //               }).toList(),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:rafael_barbershop_app/controller/booking_controller.dart';
// import 'package:rafael_barbershop_app/models/booking_models.dart';

// class DetailBooking extends StatelessWidget {
//   final DateTime date;
//   final BookingController bookingController = Get.find<BookingController>();

//   DetailBooking({Key? key, required this.date}) : super(key: key);

//   void bookAppointment(String time) {
//     final capster = bookingController.selectedCapster.value;
//     if (capster != null) {
//       BookingModel booking = BookingModel(
//         namaCapster: capster.namaCapster,
//         imageCapster: capster.imageCapster,
//         jamBooking: time,
//         hariBooking: DateFormat.EEEE().format(date),
//         tanggalBooking: date.day,
//         bulanBooking: DateFormat.MMMM().format(date),
//         tahunBooking: date.year,
//       );
//       bookingController.addBooking(booking);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             Text('Detail Capster - ${DateFormat('d MMMM yyyy').format(date)}'),
//       ),
//       body: Obx(() {
//         List<String> timeList = bookingController.timeList;
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 DateFormat.EEEE().format(date),
//                 style: const TextStyle(
//                     fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 DateFormat('d MMMM yyyy').format(date),
//                 style: TextStyle(fontSize: 16.0),
//               ),
//               SizedBox(height: 16.0),
//               Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8.0,
//                 children: timeList.map((time) {
//                   return InkWell(
//                     onTap: () => bookAppointment(time),
//                     child: Chip(
//                       label: Text(time),
//                       backgroundColor: Colors.blue,
//                       labelStyle: TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rafael_barbershop_app/controller/booking_controller.dart';

class DetailBooking extends StatelessWidget {
  final DateTime date;
  final BookingController bookingController = Get.find<BookingController>();

  DetailBooking({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Detail Capster - ${DateFormat('d MMMM yyyy').format(date)}'),
      ),
      body: Obx(() {
        List<String> timeList = bookingController.timeList;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.EEEE().format(date),
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                DateFormat('d MMMM yyyy').format(date),
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: timeList.map((time) {
                  return InkWell(
                    onTap: () => bookingController.bookAppointment(date, time),
                    child: Chip(
                      label: Text(time),
                      backgroundColor: Colors.blue,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
