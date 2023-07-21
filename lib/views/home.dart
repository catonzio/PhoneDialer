/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/home_controller.dart';
import 'package:phone_dialer/views/register_page.dart';

import 'contacts_page.dart';
import 'phone_dialer.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller.tabController,
        //to disable the swipe between tabs
        physics: const NeverScrollableScrollPhysics(),
        children: [const RegisterPage(), PhoneDialer(), ContactsPage()],
      ),
      bottomNavigationBar: TabBar(
        controller: controller.tabController,
        tabs: controller.tabs,
        // labelColor: Theme.of(context).accentColor,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: const EdgeInsets.all(5.0),
      ),
    );
  }
}
*/