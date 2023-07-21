import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  List<Contact> contacts = <Contact>[].obs;
  RxBool isLoadingContacts = false.obs;

  @override
  onInit() async {
    if (await FlutterContacts.requestPermission()) {
      loadContacts();
    } else {
      Get.snackbar("Permission denied", "Please allow contacts permission",
          snackPosition: SnackPosition.BOTTOM);
    }
    super.onInit();
  }

  void loadContacts() async {
    isLoadingContacts.value = true;
    contacts = (await FlutterContacts.getContacts())
        .where((Contact c) => !c.isBlank! && c.displayName.isNotEmpty)
        .toList();
    isLoadingContacts.value = false;
  }
}
