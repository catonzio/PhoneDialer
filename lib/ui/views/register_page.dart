import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/configs/themes.dart';
import 'package:phone_dialer/data/controllers/register_controller.dart';
import 'package:phone_dialer/ui/views/default_page.dart';
import 'package:phone_dialer/ui/views/list_page.dart';
import 'package:phone_dialer/ui/widgets/register/register_main_list.dart';
import 'package:phone_dialer/ui/widgets/register/register_scroller.dart';

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
        style: context.textTheme.displayLarge!.copyWith(color: yellow),
      ),
      subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "There are ${controller.isLoadingEntries ? '--' : controller.entries.length} call logs",
            style: context.textTheme.titleSmall!.copyWith(color: yellow),
          )),
      mainList: const RegisterMainList(),
      scrollBar: const RegisterScroller(),
      searchFunction: (String text) => controller.searchEntries(text),
    ));
  }
}
