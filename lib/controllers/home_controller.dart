import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/views/contacts_page.dart';
import 'package:phone_dialer/views/phone_dialer.dart';
import 'package:phone_dialer/views/register_page.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(
      icon: Icon(Icons.history),
    ),
    const Tab(
      icon: Icon(Icons.call),
    ),
    const Tab(
      icon: Icon(Icons.contacts),
    )
  ];

  // final RxString title = "".obs;
  // late Rx<Widget> bodyWidget;
  final List<Type> pages = [RegisterPage, PhoneDialer, ContactsPage];
  RxInt selectedIndex = 1.obs;

  // late TabController tabController;

  @override
  onInit() {
    // Get.put(PhoneController());
    // bodyWidget = (PhoneDialer(key: const ValueKey<int>(1)) as TabPage).obs;
    // title.value = "Phone Dialer";
    //tabController = TabController(length: tabs.length, vsync: this);
    // tabController.index = 1;
    super.onInit();
  }

  @override
  void onClose() {
    //tabController.dispose();
    super.onClose();
  }

  updateTab(int index) {
    if (index == selectedIndex.value) return;
    // TabPage? newPage;
    // String newTitle = "";
    Transition transition = index < selectedIndex.value
        ? Transition.leftToRight
        : Transition.rightToLeft;
    switch (pages[index]) {
      case RegisterPage:
        // Get.put(RegisterController());
        // Get.toNamed("/register");
        Get.to(() => RegisterPage(), transition: transition);
        // newPage = RegisterPage(key: ValueKey<int>(0));
        // newTitle = "Register";
        break;
      case PhoneDialer:
        // Get.put(PhoneController());
        // Get.toNamed("/phone");
        Get.to(() => PhoneDialer(), transition: transition);
        // newPage = PhoneDialer(key: const ValueKey<int>(1));
        // newTitle = "Phone Dialer";
        break;
      case ContactsPage:
        // Get.toNamed("/contacts");
        Get.to(() => ContactsPage(), transition: transition);
        break;
      // Get.put(ContactsController());
      // newPage = ContactsPage(key: const ValueKey<int>(2));
      // newTitle = "Contacts";
      // break;
    }
    // if (newPage != null && newTitle != "") {
    // bodyWidget.value = (newPage as TabPage);
    // title.value = newTitle;
    // }
    selectedIndex.value = index;
  }
}
