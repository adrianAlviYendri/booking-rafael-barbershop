import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rafael_barbershop_app/bindings/main_bindings.dart';
import 'package:rafael_barbershop_app/firebase_options.dart';
import 'package:rafael_barbershop_app/routers/app_router.dart';
import 'package:rafael_barbershop_app/routers/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => debugPrint("connected Firebase"))
      .catchError((e) => debugPrint(e.toString()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var statusUser = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          (statusUser != null) ? AppRoutes.main.name : AppRoutes.login.name,
      getPages: AppRouter.pages,
      initialBinding: MainBinding(),
    );
  }
}
