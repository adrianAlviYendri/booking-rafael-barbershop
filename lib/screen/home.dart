// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/controller/main_controller.dart';
import 'package:rafael_barbershop_app/screen/booking.dart';
import 'package:rafael_barbershop_app/screen/hair_color.dart';
import 'package:rafael_barbershop_app/screen/hair_style.dart';
import 'package:rafael_barbershop_app/widgets/drawer_home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainController = Get.find<MainControllers>();

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[800],
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Rafael BarberShop',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Obx(() {
            return mainController.showMenuIcon.value
                ? Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  )
                : SizedBox.shrink();
          }),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            unselectedLabelStyle: const TextStyle(fontSize: 13),
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: 'Booking'),
              Tab(text: 'Hair Style'),
              Tab(text: 'Hair Color'),
            ],
          ),
        ),
        drawer: Obx(() {
          return mainController.showDrawer.value
              ? const DrawerHomeScreen()
              : SizedBox.shrink();
        }),
        body: TabBarView(
          children: const [
            BookingScreen(),
            HairStyleScreen(),
            HairColorScreen(),
          ],
        ),
      ),
    );
  }
}
