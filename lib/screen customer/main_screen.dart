import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/controller/main_controller.dart';
import 'package:rafael_barbershop_app/routers/app_router.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class MainScreen extends GetView<MainControllers> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: controller.navigatorKey,
        initialRoute: AppRoutes.home.name,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor: Colors.blueGrey.shade900,
          unselectedItemColor: Colors.grey.shade500,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          onTap: (index) {
            controller.changePage(index);
          },
          currentIndex: controller.currentIndexMain.value,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: 'Beranda',
              icon: Icon(
                FontAwesomeIcons.house,
                size: 24,
              ),
            ),
            BottomNavigationBarItem(
              label: 'My Order',
              icon: Icon(
                FontAwesomeIcons.bagShopping,
                size: 24,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                FontAwesomeIcons.userSecret,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
