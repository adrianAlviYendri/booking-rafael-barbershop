// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-metode-pembayaran/bottom_sheet_add_metode.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-metode-pembayaran/metode_pembayaran_controller.dart';

class AddMetodePembayaranScreen extends StatelessWidget {
  const AddMetodePembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MetodePembayaranController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Kelola Metode Pembayaran',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.dataPembayaran.isEmpty) {
                  return const Center(child: Text('Tidak ada Data'));
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 5,
                                        child: Text(
                                          e.keterangan.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: () {
                                            controller
                                                .showDeleteConfirmationMetode(
                                                    context, e);
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            size: 28,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const BottomSheetAddMetode();
            },
          );
        },
        backgroundColor: Colors.green.shade700,
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
    );
  }
}
