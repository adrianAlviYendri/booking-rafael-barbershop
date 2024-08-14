// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/bottom_shet_add_capster.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/capster_controller.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/capster_models.dart';
// import 'package:rafael_barbershop_app/routers/app_routes.dart';

class AddCapsterScreen extends StatelessWidget {
  const AddCapsterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AddCapsterController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tambah Capster',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.dataCapster.isEmpty) {
          return const Center(child: Text('Tidak ada data menu.'));
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.dataCapster.length,
            itemBuilder: (context, index) {
              final e = controller.dataCapster[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        child: e.imageCapster != null
                            ? Image.network(
                                e.imageCapster!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes !=
                                                null
                                            ? progress.cumulativeBytesLoaded /
                                                (progress.expectedTotalBytes ??
                                                    1)
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
                            : const Placeholder(
                                color: Colors.grey,
                                fallbackHeight: 120,
                              ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[800],
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            e.namaCapster.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.showDeleteConfirmationCapster(
                                  context, e);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 25,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const BottomSheetAddCapster();
            },
          );
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
    );
  }
}
