// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-metode-pembayaran/metode_pembayaran_controller.dart';
import 'package:rafael_barbershop_app/widgets/bottom_sheet_pembayaran.dart';

class GetMetodePembayaranScreen extends StatelessWidget {
  const GetMetodePembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MetodePembayaranController());
    final arguments = Get.arguments as Map<String, dynamic>;
    final DateTime selectDate = arguments['date'] as DateTime;
    final String selectTime = arguments['time'] as String;
    final String selectMenu = arguments['menu'] as String;
    final String namaLengkap = arguments['nama_pelanggan'] as String;
    final String nomorHandphone = arguments['no_handphone'] as String;
    final String capstername = arguments['namaCapster'] as String;
    final String uid = arguments['uid'] as String;

    final int hargaMenu =
        arguments['menuPrice'] != null ? arguments['menuPrice'] as int : 0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text(
          'Metode Pembayaran',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Obx(() {
                if (controller.dataPembayaran.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: controller.dataPembayaran.length,
                    itemBuilder: (context, index) {
                      final e = controller.dataPembayaran[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: e.imageQr != null
                                  ? Image.network(
                                      e.imageQr!,
                                      loadingBuilder:
                                          (context, child, progress) {
                                        if (progress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: progress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? progress
                                                          .cumulativeBytesLoaded /
                                                      (progress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                            child: Text('Error loading image'));
                                      },
                                    )
                                  : const Placeholder(
                                      fallbackHeight: 100,
                                      color: Colors.grey,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    e.jenisMetode.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    e.keterangan.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: AppElevetedButtonWidgets(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return BottomSheetPembayaran(
                        date: selectDate,
                        time: selectTime,
                        menu: selectMenu,
                        harga: hargaMenu,
                        namaCapster: capstername,
                        namaPelanggan: namaLengkap,
                        noHandphone: nomorHandphone,
                        uid: uid,
                      );
                    },
                  );
                },
                backgroundColor: Colors.deepOrangeAccent, // Warna mencolok
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.upload_file, color: Colors.white), // Ikon unggah
                    SizedBox(width: 8),
                    Text(
                      'Upload Bukti Pembayaran',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
