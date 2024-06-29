// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

import '../controller admin/add_model_potongan_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AddCapsterController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 10,
        title: const Text(
          'HOME',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Tentukan jumlah kolom dalam grid
          mainAxisSpacing: 10.0, // Tentukan jarak antar baris
          crossAxisSpacing: 10.0, // Tentukan jarak antar kolom
          childAspectRatio:
              1.0, // Rasio lebar terhadap tinggi untuk setiap item grid
        ),
        children: controller.dataCapster
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.detailCapster.name, arguments: e);
                },
                child: Container(
                  color: Colors.amber,
                  child: Column(
                    children: [
                      Text(
                        e.namaCapster.toString(),
                      ),
                      Expanded(
                        child: e.imageCapster != null
                            ? Image.network(e.imageCapster!)
                            : const Placeholder(
                                fallbackHeight: 100,
                                color: Colors.grey,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
