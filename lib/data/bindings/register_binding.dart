import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController(), permanent: true);
  }
}
