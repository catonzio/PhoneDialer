import 'package:get/get.dart';
import 'package:phone_dialer/configs/pages.dart';
import 'package:phone_dialer/configs/routes.dart';

class HomeController extends GetxController {
  final List<String> pages = [
    Routes.registerRoute,
    Routes.phoneRoute,
    Routes.contactsRoute
  ];
  final RxInt _selectedIndex = 1.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;

  updateTab(int index) {
    if (index == selectedIndex) return;
    Pages.getPages;
    Get.toNamed(pages[index])?.whenComplete(() {
      selectedIndex = pages.indexOf(Get.currentRoute);
    });
    selectedIndex = index;
  }
}
