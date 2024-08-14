// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/controller/booking_controller.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/capster_models.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class DetailBooking extends StatefulWidget {
  final DateTime date;
  final CapsterModels capster;

  DetailBooking({
    Key? key,
    required this.date,
    required this.capster,
  }) : super(key: key);

  @override
  _DetailBookingState createState() => _DetailBookingState();
}

class _DetailBookingState extends State<DetailBooking> {
  String? selectedTime;

  final BookingController bookingController = Get.find<BookingController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Detail Booking",
          style: TextStyle(color: Colors.grey[300]),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with background image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.capster.imageCapster ??
                      'https://via.placeholder.com/200'),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Text(
                  "Capster: ${widget.capster.namaCapster}",
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Booking Information
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 4,
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey[300]),
                        const SizedBox(width: 8.0),
                        Text(
                          DateFormat.EEEE().format(widget.date),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.date_range, color: Colors.grey[300]),
                        const SizedBox(width: 8.0),
                        Text(
                          DateFormat('d MMMM yyyy').format(widget.date),
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[300]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Time Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<Map<String, bool>>(
                future: bookingController.getTimeBookings(
                    widget.date, bookingController.timeList),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.grey[300])),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: Text('Tidak ada data.',
                          style: TextStyle(color: Colors.grey[300])),
                    );
                  }

                  Map<String, bool> bookings = snapshot.data!;

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookingController.timeList.length,
                    itemBuilder: (context, index) {
                      String time = bookingController.timeList[index];
                      bool isTimeBooked = bookings[time] ?? false;
                      bool isSelected = selectedTime == time;

                      return GestureDetector(
                        onTap: isSelected
                            ? null
                            : () {
                                if (isTimeBooked) {
                                  Get.snackbar(
                                    'Jadwal Sudah Dibooking',
                                    'Silahkan pilih jadwal yang lain',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                } else {
                                  setState(() {
                                    selectedTime = time;
                                  });
                                }
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.green
                                : isTimeBooked
                                    ? Colors.grey[400]
                                    : Colors.grey[800],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            time,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 32.0),
            // Next Button
            SizedBox(
              width: 300,
              height: 50,
              child: AppElevetedButtonWidgets(
                elevation: 0,
                shadowColor: Colors.black,
                backgroundColor: Colors.green,
                borderRadius: BorderRadius.circular(12),
                child: const Text(
                  'Lanjut Ke Pilih Menu',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (selectedTime != null) {
                    Get.toNamed(
                      AppRoutes.selectMenu.name,
                      arguments: {
                        'date': widget.date,
                        'time': selectedTime,
                        'capsterName': widget.capster.namaCapster,
                      },
                    );
                  } else {
                    Get.snackbar(
                      'Peringatan',
                      'Silahkan pilih waktu terlebih dahulu',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
