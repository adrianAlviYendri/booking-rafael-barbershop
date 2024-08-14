import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/component/app_eleveted_button_widgets.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-menu/menu_controller.dart';

class BottomSheetAddmenu extends StatelessWidget {
  const BottomSheetAddmenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SelectMenuController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
      child: Column(
        children: [
          const Text(
            'Tambah Menu',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: controller.namaMenuController,
            decoration: InputDecoration(
              labelText: 'nama menu',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller.hargaController,
            decoration: InputDecoration(
              labelText: 'harga',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AppElevetedButtonWidgets(
            onPressed: () {
              controller.addDataMenu();
              Get.back();
            },
            elevation: 10,
            borderRadius: BorderRadius.circular(30),
            backgroundColor: Colors.blueGrey,
            shadowColor: Colors.black,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                'save',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
