import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController controller = Get.find<SettingsController>();
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(2),
          child: Text(
            "Settings",
            style: TextStyle(
              decoration: TextDecoration.underline,
              height: 1.5,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto-Regular',
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(width * 5, height * 1, width * 5, height * 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dark Mode", style: TextStyle(fontSize: 20)),
                Obx(() => Switch(
                      value: controller.isDarkMode,
                      onChanged: (value) => controller.toggleDarkMode(),
                    ))
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Prefix", style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: width * 20,
                  child: TextField(
                    controller: controller.prefixController,
                    onChanged: (value) => controller.setPrefix(),
                  ),
                )
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
