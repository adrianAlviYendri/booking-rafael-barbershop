import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-menu/menu_controller.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-menu/menu_models.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-menu/bottom_sheet_add_menu.dart';

class AddMenuScreen extends StatelessWidget {
  const AddMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectMenuController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Menu'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.dataMenu.isEmpty) {
          return const Center(child: Text('Tidak ada data menu.'));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.dataMenu.length,
            itemBuilder: (context, index) {
              final menu = controller.dataMenu[index];

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    menu.namaMenu ?? 'Nama Menu Tidak Tersedia',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    menu.harga != null
                        ? 'Harga: ${menu.harga}'
                        : 'Harga Tidak Tersedia',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, menu);
                    },
                  ),
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
              return const BottomSheetAddmenu();
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

  void _showDeleteConfirmationDialog(BuildContext context, MenuModels menu) {
    Get.dialog(
      AlertDialog(
        title: const Text('Konfirmasi Penghapusan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_forever, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Apakah Anda yakin ingin menghapus menu?',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red, // Text color
            ),
            onPressed: () {
              Get.find<SelectMenuController>().deleteMenu(menu);
              Get.back(); // Close the dialog
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
