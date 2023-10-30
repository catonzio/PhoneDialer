import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController());
  }
}
