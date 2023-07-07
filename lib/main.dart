import 'package:api/screens/auth/login_screen.dart';
import 'package:api/screens/images/get_image.dart';
import 'package:api/screens/images/launch_screen.dart';
import 'package:api/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/auth_getx_controller.dart';

Future<void> main() async {
  Get.put(() => AuthGetxController());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        initialRoute: '/launch_screen',
        getPages: [
          GetPage(name: '/launch_screen', page: () => LaunchScreen()),
          GetPage(name: '/MainPage_screens', page: () => MainPage()),
          GetPage(name: '/login_screen', page: () => LoginScreen()),
          GetPage(name: '/get_image', page: () => GetImage()),
        ]);
  }
}
