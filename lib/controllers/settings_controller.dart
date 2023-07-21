import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = false.obs;
  String prefix = "4146";

  @override
  void onInit() {
    isDarkMode.value = GetStorage().read("isDarkMode") ?? Get.isDarkMode;
    prefix = GetStorage().read("prefix") ?? prefix;
    super.onInit();
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    GetStorage().write("isDarkMode", isDarkMode.value);
  }

  void setPrefix(String value) {
    prefix = value;
    GetStorage().write("prefix", prefix);
  }
}
