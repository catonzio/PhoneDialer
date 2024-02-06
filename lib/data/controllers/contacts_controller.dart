import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/home_controller.dart';
import 'package:phone_dialer/data/controllers/list_controller.dart';
import 'package:phone_dialer/data/controllers/phone_controller.dart';

class ContactsController extends ListController {
  List<Contact> contacts = <Contact>[];

  final RxList<Contact> _contactsFiltered = <Contact>[].obs;
  List<Contact> get contactsFiltered => _contactsFiltered;
  set contactsFiltered(List<Contact> value) => _contactsFiltered.value = value;

  final RxMap<String, List<int>> _groups = <String, List<int>>{}.obs;
  Map<String, List<int>> get groups => _groups;
  set groups(Map<String, List<int>> value) => _groups.value = value;

  final RxBool _isLoadingContacts = false.obs;
  bool get isLoadingContacts => _isLoadingContacts.value;
  set isLoadingContacts(bool value) => _isLoadingContacts.value = value;

  final RxInt _scrollingLetterIndex = 0.obs;
  int get scrollingLetterIndex => _scrollingLetterIndex.value;
  set scrollingLetterIndex(int value) => _scrollingLetterIndex.value = value;

  @override
  onInit() async {
    if (await FlutterContacts.requestPermission()) {
      if (contacts.isEmpty) {
        isLoadingContacts = true;
        loadContacts();
      }
    } else {
      Get.snackbar("Permission denied", "Please allow contacts permission",
          snackPosition: SnackPosition.BOTTOM);
    }
    super.resetExpandableControllers(contactsFiltered);
    super.onInit();
  }

  void loadContacts() async {
    print("Loading contacts");
    // List<Group> groups = await FlutterContacts.getGroups();

    // print("Groups: ${groups.length}");

    FlutterContacts.getContacts(
            withProperties: true, deduplicateProperties: true)
        .then((contacts) {
      contacts = contacts
          .where((Contact c) => !c.isBlank! && c.displayName.isNotEmpty)
          .toList()
          // .sublist(0, 100)
          .obs;
      contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
      this.contacts = contacts;
      contactsFiltered = contacts;
      groups = buildGroups();

      isLoadingContacts = false;
    });
  }

  searchContacts(String text) {
    if (text.isNotEmpty) {
      contactsFiltered =
          (contactsFiltered.isNotEmpty ? contactsFiltered : contacts)
              .where((Contact c) =>
                  c.displayName.toLowerCase().contains(text.toLowerCase()))
              .toList();
    } else {
      contactsFiltered = contacts;
    }
    groups = buildGroups();
  }

  Map<String, List<int>> buildGroups() {
    Map<String, List<int>> groups = {};
    for (int i = 0; i < contactsFiltered.length; i++) {
      String firstLetter = contactsFiltered[i].displayName[0].toUpperCase();
      if (groups.containsKey(firstLetter)) {
        groups[firstLetter]!.add(i);
      } else {
        groups[firstLetter] = [i];
      }
    }
    super.resetExpandableControllers(contactsFiltered);
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

  void setNumberForCall(int index, bool isCall) {
    Phone? obj = contactsFiltered[index].phones.firstOrNull;
    String num = obj == null ? "" : obj.number;
    if (num.isNotEmpty) {
      super.setNumber(num, isCall);
    }
  }

  @override
  void clearText() {
    super.clearText();
    searchContacts("");
  }
}
