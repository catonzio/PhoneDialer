import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/settings_controller.dart';
import 'package:phone_dialer/views/default_page.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController controller = Get.find<SettingsController>();
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
        title: "Settings",
        body: Column(
          children: [],
        ));
  }
}
