import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final RxBool _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  set isDarkMode(bool value) => _isDarkMode.value = value;

  final RxString _prefix = "4146".obs;
  String get prefix => _prefix.value;
  set prefix(String value) => _prefix.value = value;

  final TextEditingController prefixController = TextEditingController();

  @override
  void onInit() {
    isDarkMode = GetStorage().read("isDarkMode") ?? Get.isDarkMode;
    if (isDarkMode) {
      Get.changeThemeMode(ThemeMode.dark);
    }
    prefix = GetStorage().read("prefix") ?? prefix;
    prefixController.text = prefix;
    super.onInit();
  }

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    GetStorage().write("isDarkMode", isDarkMode);
  }

  void setPrefix() {
    prefix = prefixController.text.trim();
    // prefix = value;
    GetStorage().write("prefix", prefix);
  }
}
