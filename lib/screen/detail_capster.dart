// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rafael_barbershop_app/controller/booking_controller.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/capster_models.dart';
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(AppRoutes.main.name);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
          ),
        ),
        title: Text(
          'Detail Capster',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.green,
            ),
            onPressed: () {
              Get.snackbar(
                'Informasi Capster',
                'Nama Capster: ${capster.namaCapster ?? "Tidak tersedia"}',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black,
                colorText: Colors.white,
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        List<DateTime> dayList = bookingController.dayList;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Calendar Header
              Container(
                height: 150,
                color: Colors.grey[900],
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dayList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (bookingController.isDateDisabled(dayList[index])) {
                          Get.snackbar(
                            'Tanggal Tidak Tersedia',
                            'Tanggal ini adalah Jadwal Cuti Capster.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } else {
                          Get.to(
                            () => DetailBooking(
                              date: dayList[index],
                              capster: bookingController.getSelectedCapster()!,
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        width: 100,
                        decoration: BoxDecoration(
                          color:
                              bookingController.isDateDisabled(dayList[index])
                                  ? Colors.grey[500]
                                  : const Color.fromARGB(255, 84, 54, 43),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat.EEEE().format(dayList[index]),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                            Text(
                              DateFormat('d').format(dayList[index]),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('MMMM').format(dayList[index]),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                            Text(
                              DateFormat('yyyy').format(dayList[index]),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4,
                  color: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: capster.imageCapster != null
                          ? Image.network(
                              capster.imageCapster!,
                              fit: BoxFit.cover,
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
                                return const Center(
                                    child: Text('Error loading image'));
                              },
                            )
                          : const Placeholder(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  capster.namaCapster ?? 'Nama Capster Tidak Tersedia',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
