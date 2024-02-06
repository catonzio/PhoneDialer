import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/configs/themes.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';
import 'package:phone_dialer/ui/views/contacts/contacts_main_list.dart';
import 'package:phone_dialer/ui/views/contacts/contacts_scroller.dart';
import 'package:phone_dialer/ui/views/default_page.dart';
import 'package:phone_dialer/ui/views/list_page.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactsController controller = Get.find<ContactsController>();
    return DefaultPage(
        body: ListPage(
            tag: "contacts",
            listController: controller,
            title: Text(
              "Contacts",
              style: context.textTheme.displayLarge!.copyWith(color: yellow),
            ),
            subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => Text(
                      "There are ${controller.isLoadingContacts ? '--' : controller.contacts.length} contacts",
                      style:
                          context.textTheme.titleSmall!.copyWith(color: yellow),
                    ))),
            mainList: const ContactsMainList(),
            scrollBar: const ContactsScroller(),
            searchFunction: (String text) => controller.searchContacts(text)));
  }
}
