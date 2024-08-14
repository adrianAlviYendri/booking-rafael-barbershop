import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/controller/my_order_controller.dart';
import 'package:rafael_barbershop_app/models/booking_models.dart';
import 'package:rafael_barbershop_app/screen/detail_my_order_screen.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyOrderController controller = Get.put(MyOrderController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: FutureBuilder<List<BookingModel>>(
          future: controller.fetchBookingsMyorder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No bookings yet.',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              final bookingList = snapshot.data!;
              return ListView.builder(
                itemCount: bookingList.length,
                itemBuilder: (context, index) {
                  final booking = bookingList[index];
                  return Card(
                    color: Colors.grey[800], // Dark gray for card background
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple, // Accent color
                        child: Text(
                          booking.namaCapster?[0] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        booking.namaCapster ?? '',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${booking.tanggalBooking} ${booking.bulanBooking} ${booking.tahunBooking}',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            'Time: ${booking.jamBooking}',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            'Day: ${booking.hariBooking}',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            'Payment Status: ${booking.statusPembayaran}',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.deepPurple),
                        onPressed: () {
                          // Navigate to DetailMyOrderScreen with the selected booking data
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailMyOrderScreen(booking: booking),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
