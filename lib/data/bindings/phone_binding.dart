import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/phone_controller.dart';

class PhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PhoneController>(PhoneController());
  }
}
