import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/home_controller.dart';

import '../widgets/bottom_bar_icon.dart';

class DefaultPage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final String title;
  final Widget body;
  final bool showSettingsButton;

  DefaultPage(
      {super.key,
      required this.title,
      required this.body,
      this.showSettingsButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Padding(
          padding: const EdgeInsets.all(2),
          child: Text(
            title,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              height: 1.5,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto-Regular',
            ),
          ),
        )),
        actions: [
          //To check if the settings button should be visualized
          showSettingsButton == true
              ? MaterialButton(
                  child: const Icon(Icons.settings),
                  onPressed: () =>
                      {} // Navigator.of(context).pushNamed(SettingsPage.routeName),
                  )
              : Container()
        ],
        //backgroundColor: Colors.black,
      ),
      body: body,
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: BottomBarIcon(
                    icon: const Icon(Icons.home),
                    isActive: controller.selectedIndex.value == 0,
                    onPressed: () => controller.updateTab(0),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: BottomBarIcon(
                    icon: const Icon(Icons.home),
                    isActive: controller.selectedIndex.value == 1,
                    onPressed: () => controller.updateTab(1),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: BottomBarIcon(
                    icon: const Icon(Icons.home),
                    isActive: controller.selectedIndex.value == 2,
                    onPressed: () => controller.updateTab(2),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
