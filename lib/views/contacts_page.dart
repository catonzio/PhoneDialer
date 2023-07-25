import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/contacts_controller.dart';
import 'package:phone_dialer/views/default_page.dart';

import 'tab_page.dart';

class ContactsPage extends TabPage {
  final ContactsController controller = Get.put(ContactsController());
  ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.addFakeContacts();
    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                  controller: controller.searchController,
                  onChanged: (text) => controller.searchContacts(text),
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search))),
            ),
            IconButton(
                onPressed: () => controller.clearSearch(),
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.cancel_outlined))
          ],
        ),
      ),
      Obx(() => controller.isLoadingContacts.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (controller.contactsFiltered.isEmpty
              ? const Center(child: Text("There are no contacts."))
              : Expanded(
                  child: Obx(
                  () => ListView.builder(
                    itemCount: controller.contactsFiltered.length,
                    itemBuilder: (context, index) {
                      String phone = controller
                          .contactsFiltered[index].phones.first.number
                          .toString();
                      String name =
                          controller.contactsFiltered[index].displayName;
                      return ListTile(
                        title: Text(name),
                        onTap: () => {
                          Get.dialog(AlertDialog(
                            title: Text(name),
                            content: TextButton(
                              child: Text(phone),
                              onPressed: () => controller.setCurrentNumber(phone),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("Close"))
                            ],
                          ))
                        },
                        // subtitle:
                        //     Text(controller.contacts[index].phones.first.number),
                      );
                    },
                  ),
                ))))
    ]);
  }
}
