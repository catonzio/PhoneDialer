import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/register_controller.dart';
import 'package:phone_dialer/ui/views/default_page.dart';
import 'package:phone_dialer/ui/views/list_page.dart';
import 'package:phone_dialer/ui/views/register/register_main_list.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();
    return DefaultPage(
        body: ListPage(
      tag: "register",
      listController: controller,
      title: Text(
        "Call logs",
        style: context.textTheme.displayLarge,
      ),
      subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "There are ${controller.isLoadingEntries ? '--' : controller.entries.length} call logs",
            style: context.textTheme.titleSmall,
          )),
      mainList: const RegisterMainList(),
      scrollBar: Container(),
      searchFunction: (String text) => controller.searchEntries(text),
    ));
  }
}
