// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:rafael_barbershop_app/component/date_time_services_widgets.dart';
// import 'package:rafael_barbershop_app/models/capster_models.dart';
// import 'package:rafael_barbershop_app/screen/detail_booking.dart';

// class DetailCapsterScreen extends StatelessWidget {
//   final CapsterModels capster;

//   DetailCapsterScreen({
//     required this.capster,
//   });

//   @override
//   Widget build(BuildContext context) {
//     List<DateTime> dayList =
//         DateTimeService.generateDayList(); // Gunakan DateTimeService

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Capster'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 100,
//             color: Colors.grey,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: dayList.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Get.to(
//                       () => DetailBooking(
//                         date: dayList[index],
//                         capster: capster,
//                       ),
//                     );
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                     width: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.amber,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           DateFormat('d').format(dayList[index]),
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           DateFormat.EEEE().format(dayList[index]),
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                         Text(
//                           DateFormat('yyyy').format(dayList[index]),
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             height: 200,
//             width: double.infinity,
//             child: capster.imageCapster != null
//                 ? Image.network(capster.imageCapster!)
//                 : Placeholder(fallbackHeight: 100, color: Colors.grey),
//           ),
//           Container(
//             color: Colors.green,
//             child: capster.namaCapster != null
//                 ? Text(capster.namaCapster!)
//                 : Placeholder(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rafael_barbershop_app/component/date_time_services_widgets.dart';
import 'package:rafael_barbershop_app/controller/booking_controller.dart';
import 'package:rafael_barbershop_app/models/capster_models.dart';
import 'package:rafael_barbershop_app/screen/detail_booking.dart';

class DetailCapsterScreen extends StatelessWidget {
  final CapsterModels capster;
  final BookingController bookingController = Get.put(BookingController());

  DetailCapsterScreen({
    required this.capster,
  });

  @override
  Widget build(BuildContext context) {
    bookingController.setSelectedCapster(capster);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Capster'),
      ),
      body: Obx(() {
        List<DateTime> dayList = bookingController.dayList;
        return Column(
          children: [
            Container(
              height: 100,
              color: Colors.grey,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dayList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailBooking(
                            date: dayList[index],
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('d').format(dayList[index]),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.EEEE().format(dayList[index]),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            DateFormat('yyyy').format(dayList[index]),
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: capster.imageCapster != null
                  ? Image.network(capster.imageCapster!)
                  : Placeholder(fallbackHeight: 100, color: Colors.grey),
            ),
            Container(
              color: Colors.green,
              child: capster.namaCapster != null
                  ? Text(capster.namaCapster!)
                  : Placeholder(),
            ),
          ],
        );
      }),
    );
  }
}
