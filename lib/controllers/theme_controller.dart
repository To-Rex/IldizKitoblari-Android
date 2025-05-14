import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final isDarkMode = false.obs;
  final box = GetStorage();
  final String _localeKey = 'locale';

  @override
  void onInit() {
    super.onInit();
    // Saqlangan mavzuni yuklash
    isDarkMode.value = box.read('isDarkMode') ?? false;
    // Saqlangan tilni yuklash
    final savedLocale = box.read(_localeKey);
    if (savedLocale != null) {
      Get.updateLocale(Locale(savedLocale));
    }
  }

  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    saveSettings();
  }

  void saveSettings() {
    box.write('isDarkMode', isDarkMode.value);
  }

  // Tilni saqlash funksiyasi
  void saveLocale(String locale) {
    box.write(_localeKey, locale);
  }
}