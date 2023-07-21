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

  final List<Type> pages = [RegisterPage, PhoneDialer, ContactsPage];
  RxInt selectedIndex = 1.obs;

  // late TabController tabController;

  @override
  onInit() {
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
    Widget newPage = Container();
    switch (pages[index]) {
      case RegisterPage:
        newPage = RegisterPage();
        break;
      case PhoneDialer:
        newPage = PhoneDialer();
        break;
      case ContactsPage:
        newPage = ContactsPage();
        break;
    }
    Get.off(newPage,
        transition: index > selectedIndex.value
            ? Transition.rightToLeft
            : Transition.leftToRight);
    //.then((value) => selectedIndex.value = index);
    // Get.offAndToNamed(routes[index]);
    selectedIndex.value = index;
    //tabController.index = index;
  }
}
