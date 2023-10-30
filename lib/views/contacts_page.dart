import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';
import 'package:phone_dialer/views/default_page.dart';
import 'package:phone_dialer/views/list_page.dart';
import 'package:phone_dialer/widgets/contacts_group_element.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      body: GetX<ContactsController>(
        init: ContactsController(),
        builder: (controller) {
          return ListPage(
              tag: "contacts",
              listController: controller,
              title: const Text(
                "Contacts",
                style: TextStyle(fontSize: 50.0),
              ),
              subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "There are ${controller.contacts.length} contacts",
                    style: const TextStyle(fontSize: 15.0),
                  )),
              mainList: buildMainList(context, controller),
              scrollBar: buildScroller(context, controller),
              searchFunction: (String text) => controller.searchContacts(text));
        },
      ),
    );
  }

  Widget buildMainList(BuildContext context, ContactsController controller) {
    List<String> sortedGroups = controller.groups.keys.toList()..sort();

    return SliverToBoxAdapter(
        child: controller.isLoadingContacts
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (controller.groups.isEmpty
                ? const Center(
                    child: Text("No contacts found"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sortedGroups.length,
                    itemBuilder: (context, index) {
                      String group = sortedGroups[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: ContactsGroupElement(
                          group: group,
                          // elements: buildElementsList,
                        ),
                      );
                    },
                  )));
  }

  Widget buildScroller(BuildContext context, ContactsController controller) {
    // List<String> keys = controller.groups.keys.toList()..sort();
    return Container();
    // return Obx(() => keys.isEmpty
    //     ? Container()
    //     : RotatedBox(
    //         quarterTurns: 1,
    //         child: Slider(
    //           divisions: keys.length,
    //           value: controller.scrollingLetterIndex.toDouble(),
    //           label: keys.toList()[controller.scrollingLetterIndex],
    //           onChanged: (v) =>
    //               controller.scrollingLetterIndex = v.toInt(),
    //         )));
  }
}
