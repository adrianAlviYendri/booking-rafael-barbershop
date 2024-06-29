// ignore_for_file: unnecessary_import

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rafael_barbershop_app/controller/main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainControllers>(() => MainControllers());
  }
}
