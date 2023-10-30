import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ContactsController>(ContactsController(), permanent: true);
  }
}
