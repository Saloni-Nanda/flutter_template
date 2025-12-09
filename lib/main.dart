import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Theme Controller
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        title: 'Hotel Paradise',
        debugShowCheckedModeBanner: false,
        theme: themeController.currentTheme.value,
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
      );
    });
  }
}
