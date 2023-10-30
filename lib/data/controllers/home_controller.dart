import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/configs/routes.dart';
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
  final RxInt _selectedIndex = 1.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;

  @override
  void onClose() {
    //tabController.dispose();
    super.onClose();
  }

  updateTab(int index) {
    if (index == selectedIndex) return;
    switch (pages[index]) {
      case RegisterPage:
        Get.toNamed(Routes.registerRoute);
        break;
      case PhoneDialer:
        Get.toNamed(Routes.phoneRoute);
        break;
      case ContactsPage:
        Get.toNamed(Routes.contactsRoute);
        break;
    }
    selectedIndex = index;
  }
}
