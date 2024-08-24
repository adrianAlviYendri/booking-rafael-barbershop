// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/controller/main_controller.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

class DrawerHomeScreen extends StatelessWidget {
  const DrawerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mainController = Get.find<MainControllers>();

    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.date_range,
                  text: 'Kelola List Booking Per Hari',
                  route: AppRoutes.laporanPerHari.name,
                ),
                _buildDrawerItem(
                  icon: Icons.calendar_today_rounded,
                  text: 'Kelola List Booking Per Bulan',
                  route: AppRoutes.laporanPerBulan.name,
                ),
                _buildDrawerItem(
                  icon: Icons.calendar_month_outlined,
                  text: 'Kelola List Booking Per Tahun',
                  route: AppRoutes.laporanPerTahun.name,
                ),
                _buildDrawerItem(
                  icon: Icons.edit_calendar_outlined,
                  text: 'Kelola Jadwal Cuti Capster',
                  route: AppRoutes.kelolaJadwalCuti.name,
                ),
                if (mainController.userRole.value == 1) ...[
                  _buildDrawerItem(
                    icon: Icons.people,
                    text: 'Kelola Data Pelanggan',
                    route: AppRoutes.kelolaDataPelanggan.name,
                  ),
                  _buildDrawerItem(
                    icon: Icons.menu,
                    text: 'Kelola Menu',
                    route: AppRoutes.addMenu.name,
                  ),
                  _buildDrawerItem(
                    icon: Icons.person_add,
                    text: 'Kelola Capster',
                    route: AppRoutes.addCapster.name,
                  ),
                  _buildDrawerItem(
                    icon: Icons.style,
                    text: 'Kelola Hair Style',
                    route: AppRoutes.kelolaHairStyle.name,
                  ),
                  _buildDrawerItem(
                    icon: Icons.color_lens,
                    text: 'Kelola Hair Color',
                    route: AppRoutes.kelolaHairColor.name,
                  ),
                  _buildDrawerItem(
                    icon: Icons.payment,
                    text: 'Kelola Metode Pembayaran',
                    route: AppRoutes.addMetodePembayaran.name,
                  ),
                ],
                // Item yang selalu ditampilkan
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon, required String text, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(text),
      onTap: () {
        Get.toNamed(route);
      },
    );
  }
}
