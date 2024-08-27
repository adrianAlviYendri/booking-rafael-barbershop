// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewDetailBookingScreen extends StatelessWidget {
  const ViewDetailBookingScreen({super.key});

  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        return null; // Tidak ada user ID
      }

      // Pertama cek di koleksi 'admins'
      final adminSnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .where('uid', isEqualTo: userId)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        // Jika ditemukan di koleksi 'admins', kembalikan data admin
        return adminSnapshot.docs.first.data();
      } else {
        // Jika tidak ditemukan di koleksi 'admins', cek di koleksi 'customer'
        final customerSnapshot = await FirebaseFirestore.instance
            .collection('customer')
            .where('uid', isEqualTo: userId)
            .get();

        if (customerSnapshot.docs.isEmpty) {
          return null; // Data pengguna tidak ditemukan
        } else {
          return customerSnapshot.docs.first
              .data(); // Mengembalikan data pengguna
        }
      }
    } catch (e) {
      print('Error saat mengambil data pengguna: $e');
      return null; // Mengembalikan null jika ada error
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;

    // Cast arguments to the correct types
    final DateTime selectedDate = arguments['selectedDate'] as DateTime;
    final String selectedTime = arguments['selectedTime'] as String;
    final String selectedMenu = arguments['selectedMenu'] as String;
    final int menuPrice = arguments['menuPrice'] as int;
    final String capsterName = arguments['capsterName'];

    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    final String formattedDate = dateFormat.format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Detail Booking',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.white),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: Colors.grey[700],
            height: 2.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                  child: Text('Data pengguna tidak ditemukan.'));
            }

            final userData = snapshot.data!;
            final namaLengkap =
                userData['nama_lengkap'] ?? 'Nama Tidak Tersedia';
            final nomorHandphone =
                userData['nomor_handphone'] ?? 'Nomor Tidak Tersedia';
            final uid = userData['uid'] ?? 'UID Tidak Tersedia';

            return ListView(
              children: [
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                            Icons.person, 'Nama Capster', capsterName),
                        _buildInfoRow(Icons.calendar_today, 'Jadwal Booking',
                            formattedDate),
                        _buildInfoRow(Icons.access_time, 'Jam', selectedTime),
                        _buildInfoRow(Icons.menu, 'Menu Booking', selectedMenu),
                        _buildInfoRow(Icons.monetization_on, 'Harga Menu',
                            'Rp.$menuPrice'),
                        _buildInfoRow(
                            Icons.person, 'Nama Pelanggan', namaLengkap),
                        _buildInfoRow(
                            Icons.phone, 'Nomor Handphone', nomorHandphone),
                        Card(
                          elevation: 5,
                          color: Colors.orange[400],
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Wrap(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.moneyBillTransfer,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Jumlah Yang Harus Di Transfer Rp.$menuPrice',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.getMetodePembayaran.name,
                              arguments: {
                                'date': selectedDate,
                                'time': selectedTime,
                                'menu': selectedMenu,
                                'menuPrice': menuPrice,
                                'namaCapster': capsterName,
                                'nama_pelanggan': namaLengkap,
                                'no_handphone': nomorHandphone,
                                'uid': uid,
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Lanjut ke Pembayaran',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
