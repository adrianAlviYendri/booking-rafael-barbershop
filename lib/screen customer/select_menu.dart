import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-menu/menu_controller.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class SelectMenuScreen extends StatelessWidget {
  const SelectMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectMenuController());
    final arguments = Get.arguments as Map<String, dynamic>;
    final DateTime selectDate = arguments['date'];
    final String selectTime = arguments['time'];
    final String capsterName = arguments['capsterName'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Pilih Menu',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.grey[300]),
      ),
      body: Obx(() {
        if (controller.dataMenu.isEmpty) {
          return const Center(
            child: Text(
              'Tidak ada data menu.',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: controller.dataMenu
                      .map(
                        (menu) => Obx(() {
                          final isSelected =
                              controller.selectedMenu.value == menu.namaMenu;
                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: isSelected ? Colors.green : Colors.grey[800],
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              leading: Icon(
                                isSelected
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked_outlined,
                                size: 40,
                                color: Colors.blueAccent,
                              ),
                              title: Text(
                                menu.namaMenu ?? 'Nama Menu Tidak Tersedia',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                menu.harga != null
                                    ? 'Harga: ${menu.harga}'
                                    : 'Harga Tidak Tersedia',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[400],
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right,
                                color: Colors.blueAccent,
                              ),
                              onTap: () {
                                controller.selectedMenu.value = menu.namaMenu;
                                controller.hargaMenu.value = menu.harga;
                                Get.snackbar(
                                  'Menu Dipilih',
                                  'Anda memilih ${menu.namaMenu}',
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              },
                            ),
                          );
                        }),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (controller.selectedMenu.value != null) {
                        Get.toNamed(
                          AppRoutes.viewDetailBooking.name,
                          arguments: {
                            'selectedMenu': controller.selectedMenu.value,
                            'selectedDate': selectDate,
                            'selectedTime': selectTime,
                            'menuPrice': controller.hargaMenu.value,
                            'capsterName': capsterName,
                          },
                        );
                      } else {
                        Get.snackbar(
                          'Peringatan',
                          'Silahkan pilih menu terlebih dahulu',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.orange,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: const Text(
                      'Lanjut ke Detail Booking',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
