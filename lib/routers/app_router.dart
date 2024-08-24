// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/bindings/main_bindings.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-data-customer.dart/detail_data_customer.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola%20-capster/kelola_capster_screen.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-hair-color/kelola_hair_color_screen.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-hair-style/kelola_hair_style_screen.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-menu/kelola_menu_screen.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-data-customer.dart/kelola_customer_screen.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-metode-pembayaran/kelola_metode_pembayaran_screen.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-jadwal-cuti-capster/kelola_jadwal_cuti_screen.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-laporan-booking/laporan_per_bulan.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-laporan-booking/laporan_per_hari.dart';
import 'package:rafael_barbershop_app/screen%20admin/kelola-laporan-booking/laporan_per_tahun.dart';
import 'package:rafael_barbershop_app/screen%20customer/pilih_jam.dart';
import 'package:rafael_barbershop_app/screen%20customer/pilih_jadwal.dart';
import 'package:rafael_barbershop_app/screen%20customer/detail_my_order.dart';
import 'package:rafael_barbershop_app/screen%20customer/home.dart';
// import 'package:rafael_barbershop_app/screen%20admin/login_admin_screen.dart';
import 'package:rafael_barbershop_app/screen%20customer/login.dart';
import 'package:rafael_barbershop_app/screen%20customer/main_screen.dart';
import 'package:rafael_barbershop_app/screen%20customer/my_order.dart';
import 'package:rafael_barbershop_app/screen%20customer/pembayaran.dart';
import 'package:rafael_barbershop_app/screen%20customer/profile.dart';
import 'package:rafael_barbershop_app/screen%20customer/register.dart';
import 'package:rafael_barbershop_app/screen%20customer/select_menu.dart';
import 'package:rafael_barbershop_app/screen%20customer/view_detail_booking.dart';

class AppRouter {
  static final pages = [
    GetPage(
      name: AppRoutes.register.name,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.login.name,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.main.name,
      page: () => const MainScreen(),
      binding: MainBinding(),
      bindings: [
        MainBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.detailCapster.name,
      page: () => DetailCapsterScreen(capster: Get.arguments),
    ),
    GetPage(
      name: AppRoutes.detailBooking.name,
      page: () => DetailBooking(
        date: Get.arguments,
        capster: Get.arguments,
      ),
    ),
    GetPage(
      name: AppRoutes.laporanPerHari.name,
      page: () => const LaporanPerhariScreen(),
    ),
    GetPage(
      name: AppRoutes.laporanPerBulan.name,
      page: () => const LaporanPerBulanScreen(),
    ),
    GetPage(
      name: AppRoutes.laporanPerTahun.name,
      page: () => const LaporanPerTahunScreen(),
    ),
    GetPage(
      name: AppRoutes.addCapster.name,
      page: () => const AddCapsterScreen(),
    ),
    GetPage(
      name: AppRoutes.kelolaJadwalCuti.name,
      page: () => KelolaJadwalCutiScreen(),
    ),
    GetPage(
      name: AppRoutes.addMetodePembayaran.name,
      page: () => const AddMetodePembayaranScreen(),
    ),
    GetPage(
      name: AppRoutes.getMetodePembayaran.name,
      page: () => const GetMetodePembayaranScreen(),
    ),
    GetPage(
      name: AppRoutes.addMenu.name,
      page: () => const AddMenuScreen(),
    ),
    GetPage(
      name: AppRoutes.selectMenu.name,
      page: () => const SelectMenuScreen(),
    ),
    GetPage(
      name: AppRoutes.viewDetailBooking.name,
      page: () => const ViewDetailBookingScreen(),
    ),
    GetPage(
      name: AppRoutes.detailMyOrder.name,
      page: () => DetailMyOrderScreen(
        booking: Get.arguments,
      ),
    ),
    GetPage(
      name: AppRoutes.kelolaHairStyle.name,
      page: () => const AddHairStyleScreen(),
    ),
    GetPage(
      name: AppRoutes.kelolaHairColor.name,
      page: () => const AddHairColorScreen(),
    ),
    GetPage(
      name: AppRoutes.kelolaDataPelanggan.name,
      page: () => const KelolaCustomerScreen(),
    ),
    GetPage(
      name: AppRoutes.detailDataCustomer.name,
      page: () => DetailDataCustomer(
        customerData: Get.arguments,
      ),
    ),
  ];

  static Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.home.name) {
      return GetPageRoute(
        settings: settings,
        routeName: AppRoutes.home.name,
        page: () => const HomeScreen(),
        binding: MainBinding(),
        transition: Transition.noTransition,
      );
    }
    if (settings.name == AppRoutes.myOrder.name) {
      return GetPageRoute(
        settings: settings,
        routeName: AppRoutes.myOrder.name,
        page: () => const MyOrderScreen(),
        binding: MainBinding(),
        transition: Transition.noTransition,
      );
    }
    if (settings.name == AppRoutes.profile.name) {
      return GetPageRoute(
        settings: settings,
        routeName: AppRoutes.profile.name,
        page: () => const ProfileScreen(),
        binding: MainBinding(),
        transition: Transition.noTransition,
      );
    }
    return null;
  }
}
