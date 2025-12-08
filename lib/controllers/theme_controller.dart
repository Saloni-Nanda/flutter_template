import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Default Initial Theme
  Rx<ThemeData> currentTheme = ThemeData.light().copyWith(
    primaryColor: const Color(0xFF4A90E2),
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF4A90E2),
      secondary: Color(0xFF50E3C2),
    ),
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchThemeConfig();
  }

  void fetchThemeConfig() async {
    // Simulate API Call
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock API Response
    final Map<String, dynamic> apiResponse = {
      "primary": 0xFF4A90E2,
      "secondary": 0xFF50E3C2,
      "background": 0xFFFFFFFF,
      "fontFamily": "Mulish"
    };

    updateThemeFromApi(apiResponse);
  }

  void updateThemeFromApi(Map<String, dynamic> config) {
    currentTheme.value = ThemeData.light().copyWith(
      primaryColor: Color(config['primary']),
      scaffoldBackgroundColor: Color(config['background']),
      colorScheme: ColorScheme.light(
        primary: Color(config['primary']),
        secondary: Color(config['secondary']),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontFamily: 'Mulish'),
        bodyMedium: TextStyle(fontFamily: 'Mulish'),
      ),
    );
  }
}
