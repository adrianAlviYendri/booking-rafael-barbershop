// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class MainControllers extends GetxController
    with GetSingleTickerProviderStateMixin {
  var currentIndexMain = 0.obs;

  // index main controller
  final pages = <String>[
    AppRoutes.home.name,
    AppRoutes.profile.name,
  ];

  void changePage(int index) {
    currentIndexMain.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
