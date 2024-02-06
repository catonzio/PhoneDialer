import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/home_controller.dart';

import 'bottom_bar_icon.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: BottomBarIcon(
                  icon: const Icon(Icons.history),
                  isActive: controller.selectedIndex == 0,
                  onPressed: () => controller.updateTab(0),
                ),
              ),
              Expanded(
                flex: 1,
                child: BottomBarIcon(
                  icon: const Icon(Icons.call),
                  isActive: controller.selectedIndex == 1,
                  onPressed: () => controller.updateTab(1),
                ),
              ),
              Expanded(
                flex: 1,
                child: BottomBarIcon(
                  icon: const Icon(Icons.contacts),
                  isActive: controller.selectedIndex == 2,
                  onPressed: () => controller.updateTab(2),
                ),
              ),
            ],
          ),
        ));
  }
}
