import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/contacts_controller.dart';

class ListPage extends StatelessWidget {
  final ContactsController controller = Get.put(ContactsController());
  ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Contact> files = controller.contactsFiltered.value;

    return SafeArea(
      child: Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: CustomScrollView(slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: false,
              toolbarHeight: 500,
              title: Text("Contacts"),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Obx(
                      () => controller.isLoadingContacts.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : files.isEmpty
                              ? const Padding(
                                  padding:
                                      EdgeInsets.only(top: 32.0, bottom: 16),
                                  child: Center(
                                    child: Text("Non sono presenti documenti"),
                                  ),
                                )
                              : Column(
                                  children: files
                                      .map((e) => ListTile(
                                            title: Text(e.displayName),
                                          ))
                                      .toList(),
                                ),
                    )))
          ]),
        ),
      ),
    );
  }
}
