import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/contacts_controller.dart';
import 'package:phone_dialer/views/default_page.dart';
import 'package:phone_dialer/views/list_page.dart';
import 'package:phone_dialer/widgets/contact_element.dart';
import 'package:phone_dialer/widgets/contacts_group_element.dart';

class ContactsPage extends StatelessWidget {
  final ContactsController controller = Get.put(ContactsController());
  ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      body: ListPage(
          tag: "contacts",
          title: const Text(
            "Contacts",
            style: TextStyle(fontSize: 50.0, color: Colors.white),
          ),
          subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "There are ${controller.contacts.length} contacts",
                style: const TextStyle(fontSize: 15.0, color: Colors.white),
              )),
          mainList: buildMainList(context),
          scrollBar: buildScroller(context),
          searchFunction: (String text) => controller.searchContacts(text)),
    );
  }

  Widget buildMainList(BuildContext context) {
    return Obx(() => controller.isLoadingContacts.value
        ? const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SliverToBoxAdapter(
            child: Column(children: [
              for (String group in controller.groups.keys.toList()..sort())
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: ContactsGroupElement(
                      group: group, elements: buildElementsList),
                )
            ]),
          ));
  }

  List<Widget> buildElementsList(BuildContext context, List<int> idxs) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    List<Widget> res = <Widget>[];
    for (int i = 0; i < idxs.length; i++) {
      if (i > 0) {
        res.add(Padding(
            padding: EdgeInsets.fromLTRB(12 + width * 2 + height * 4, 0, 8, 0),
            child: const Divider()));
      }
      res.add(ContactElement(contact: controller.contacts[idxs[i]], index: i));
    }
    return res;
  }

  Widget buildScroller(BuildContext context) {
    // List<String> keys = controller.groups.keys.toList()..sort();
    return Container();
    // return Obx(() => keys.isEmpty
    //     ? Container()
    //     : RotatedBox(
    //         quarterTurns: 1,
    //         child: Slider(
    //           divisions: keys.length,
    //           value: controller.scrollingLetterIndex.value.toDouble(),
    //           label: keys.toList()[controller.scrollingLetterIndex.value],
    //           onChanged: (v) =>
    //               controller.scrollingLetterIndex.value = v.toInt(),
    //         )));
  }
}
