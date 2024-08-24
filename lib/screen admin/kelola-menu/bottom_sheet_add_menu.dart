import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-menu/menu_controller.dart';

class BottomSheetAddmenu extends StatelessWidget {
  const BottomSheetAddmenu({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SelectMenuController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tambah Menu',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller.namaMenuController,
            decoration: InputDecoration(
              labelText: 'Nama Menu',
              prefixIcon: const Icon(Icons.menu),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.hargaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Harga',
              prefixIcon: const Icon(Icons.attach_money),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
          const SizedBox(height: 30),
          AppElevetedButtonWidgets(
            onPressed: () {
              controller.addDataMenu();
              Get.back();
            },
            elevation: 10,
            borderRadius: BorderRadius.circular(12.0),
            backgroundColor: Colors.blueGrey,
            shadowColor: Colors.black,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Text(
                'Simpan',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
