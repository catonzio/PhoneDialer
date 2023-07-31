import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import 'phone_controller.dart';

class ListController extends GetxController {
  RxBool isScrolling = false.obs;
  RxBool isAtBottom = false.obs;
  Rx<DateTime> lastScrolled =
      DateTime.now().subtract(const Duration(days: 1)).obs;
  Timer? scrollingTimer;
  RxBool isSearching = false.obs;
  List<ExpandableController> expandableControllers =
      <ExpandableController>[].obs;

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    scrollController.addListener(reactToScroll);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(reactToScroll);
    for (var controller in expandableControllers) {
      controller.value = false;
      controller.dispose();
    }
    super.onClose();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.clear();
    searchController.dispose();
    isScrolling = false.obs;
    isAtBottom = false.obs;
    for (var controller in expandableControllers) {
      controller.value = false;
      controller.dispose();
    }
    super.dispose();
  }

  void updateExpandableController(int index, bool value) {
    // if true, reset all other controllers
    if (value) {
      int idxTrue =
          expandableControllers.indexWhere((element) => element.expanded);
      if (idxTrue != -1) {
        expandableControllers[idxTrue] = ExpandableController(
            initialExpanded: false); // reset the previous expanded controller
      }
    }
    expandableControllers[index] = ExpandableController(initialExpanded: value);
  }

  resetExpandableControllers(List<dynamic> entries) {
    expandableControllers = List<ExpandableController>.generate(entries.length,
        (int index) => ExpandableController(initialExpanded: false)).obs;
  }

  reactToScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    print("Scrooll");
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print("Reached the bottom");
      isAtBottom.value = true;
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      print("Reached the top");
    }
    if (DateTime.now().difference(lastScrolled.value).inSeconds > 1) {
      lastScrolled = DateTime.now().obs;
      isScrolling.value = true;
      isAtBottom.value = false;
      scrollingTimer?.cancel();
      scrollingTimer = Timer(const Duration(seconds: 5), () {
        isScrolling.value = false;
      });
    }
  }

  void moveAt(int index) {
    scrollController.animateTo(
        scrollController.position
            .minScrollExtent, // + groups[groups.keys.elementAt(index)]![0] * 80.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease);
  }

  void setNumber(String number, bool call) {
    PhoneController phoneController = Get.find<PhoneController>();
    phoneController.setText(number);
    Get.find<HomeController>().updateTab(1);
    if (call) {
      phoneController.makeCall();
    }
  }
}
