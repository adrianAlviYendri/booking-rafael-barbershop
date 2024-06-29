// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/bindings/main_bindings.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';
import 'package:rafael_barbershop_app/screen%20admin/add_capster_screen.dart';
import 'package:rafael_barbershop_app/screen/detail_capster.dart';
import 'package:rafael_barbershop_app/screen/home.dart';
import 'package:rafael_barbershop_app/screen%20admin/login_admin_screen.dart';
import 'package:rafael_barbershop_app/screen/login.dart';
import 'package:rafael_barbershop_app/screen/main_screen.dart';
import 'package:rafael_barbershop_app/screen/profile.dart';
import 'package:rafael_barbershop_app/screen/register.dart';

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
      name: AppRoutes.loginAdmin.name,
      page: () => const LoginAdminScreen(),
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
      name: AppRoutes.addCapster.name,
      page: () => const AddCapsterScreen(),
    ),
    GetPage(
      name: AppRoutes.detailCapster.name,
      page: () => DetailCapsterScreen(capster: Get.arguments),
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
    if (settings.name == AppRoutes.profile.name) {
      return GetPageRoute(
        settings: settings,
        routeName: AppRoutes.profile.name,
        page: () => const ProfileScreen(),
        binding: MainBinding(),
        transition: Transition.noTransition,
      );
    }
  }
}
