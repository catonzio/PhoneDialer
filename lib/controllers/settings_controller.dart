import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = false.obs;
  RxString prefix = "4146".obs;
  final TextEditingController prefixController = TextEditingController();

  @override
  void onInit() {
    isDarkMode.value = GetStorage().read("isDarkMode") ?? Get.isDarkMode;
    if (isDarkMode.value) {
      Get.changeThemeMode(ThemeMode.dark);
    }
    prefix.value = GetStorage().read("prefix") ?? prefix.value;
    prefixController.text = prefix.value;
    super.onInit();
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    GetStorage().write("isDarkMode", isDarkMode.value);
  }

  void setPrefix() {
    prefix.value = prefixController.text.trim();
    // prefix.value = value;
    GetStorage().write("prefix", prefix.value);
  }
}
