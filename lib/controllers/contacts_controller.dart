import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/home_controller.dart';
import 'package:phone_dialer/controllers/phone_controller.dart';

class ContactsController extends GetxController {
  List<Contact> contacts = <Contact>[];
  RxList<Contact> contactsFiltered = <Contact>[].obs;
  RxMap<String, List<int>> groups = <String, List<int>>{}.obs;
  RxBool isLoadingContacts = false.obs;
  RxInt scrollingLetterIndex = 0.obs;

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
    print("Loading contacts");
    isLoadingContacts.value = true;
    contacts = (await FlutterContacts.getContacts(withProperties: true))
        .where((Contact c) => !c.isBlank! && c.displayName.isNotEmpty)
        .toList()
        .obs;
    contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
    contactsFiltered.value = contacts;
    isLoadingContacts.value = false;
    groups.value = buildGroups();
    print("Contacts loaded");
  }

  searchContacts(String text) {
    if (text.isNotEmpty) {
      contactsFiltered.value = contactsFiltered
          .where((Contact c) =>
              c.displayName.toLowerCase().contains(text.toLowerCase()))
          .toList();
    } else {
      contactsFiltered.value = contacts;
    }
    groups.value = buildGroups();
  }

  buildGroups() {
    Map<String, List<int>> groups = {};
    for (int i = 0; i < contactsFiltered.length; i++) {
      String firstLetter = contactsFiltered[i].displayName[0].toUpperCase();
      if (groups.containsKey(firstLetter)) {
        groups[firstLetter]!.add(i);
      } else {
        groups[firstLetter] = [i];
      }
    }
    return groups;
  }

  // clearSearch() {
  //   searchController.clear();
  //   searchContacts("");
  //   // loadContacts();
  // }

  // addFakeContacts() async {
  //   var rng = Random();
  //
  //   for (int i = 0; i < 10; i++) {
  //     Contact newContact = Contact()
  //       ..name.first = String.fromCharCodes(
  //           List.generate(10, (index) => rng.nextInt(33) + 89))
  //       ..name.last = String.fromCharCodes(
  //           List.generate(10, (index) => rng.nextInt(33) + 89))
  //       ..phones = [Phone((rng.nextInt(900000) + 100000).toString())];
  //     await newContact.insert();
  //   }
  // }

  setCurrentNumber(String phone) {
    Get.back();
    Get.find<PhoneController>().setText(phone);
    Get.find<HomeController>().updateTab(1);
  }
}
