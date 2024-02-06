import 'dart:async';
// import 'dart:js';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import 'phone_controller.dart';

abstract class ListController extends GetxController {
  final RxBool _isScrolling = false.obs;
  bool get isScrolling => _isScrolling.value;
  set isScrolling(bool value) => _isScrolling.value = value;

  final RxBool _isAtBottom = false.obs;
  bool get isAtBottom => _isAtBottom.value;
  set isAtBottom(bool value) => _isAtBottom.value = value;

  final Rx<DateTime> _lastScrolled =
      DateTime.now().subtract(const Duration(days: 1)).obs;
  DateTime get lastScrolled => _lastScrolled.value;
  set lastScrolled(DateTime value) => _lastScrolled.value = value;

  Timer? scrollingTimer;

  final RxBool _isSearching = false.obs;
  bool get isSearching => _isSearching.value;
  set isSearching(bool value) => _isSearching.value = value;

  final RxList<ExpandableController> _expandableControllers =
      <ExpandableController>[].obs;
  List<ExpandableController> get expandableControllers =>
      _expandableControllers;
  set expandableControllers(List<ExpandableController> value) =>
      _expandableControllers.value = value;

  final RxString searchText = "".obs;

  // final TextEditingController searchController = TextEditingController();
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
    // searchController.clear();
    // searchController.dispose();
    searchText.value = "";
    isScrolling = false;
    isAtBottom = false;
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
    // print("Scrooll");
    // if (scrollController.offset >= scrollController.position.maxScrollExtent &&
    //     !scrollController.position.outOfRange) {
    //   print("Reached the bottom");
    //   isAtBottom = true;
    // }
    if (scrollController.offset >= 200 &&
        !scrollController.position.outOfRange) {
      // print("Reached the bottom");
      isAtBottom = true;
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      isAtBottom = false;
      // print("Reached the top");
    }
    if (DateTime.now().difference(lastScrolled).inSeconds > 1) {
      lastScrolled = DateTime.now();
      isScrolling = true;
      isAtBottom = false;
      scrollingTimer?.cancel();
      scrollingTimer = Timer(const Duration(seconds: 5), () {
        isScrolling = false;
        isAtBottom = false;
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

  void clearText() {
    // searchController.clear();
    searchText.value = "";
    isSearching = false;
  }
}
