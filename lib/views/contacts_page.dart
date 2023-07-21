import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/contacts_controller.dart';
import 'package:phone_dialer/views/default_page.dart';

class ContactsPage extends StatelessWidget {
  final ContactsController controller = Get.put(ContactsController());
  ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
        title: "Contacts",
        body: ListView.builder(
          itemCount: controller.contacts.length,
          itemBuilder: (context, index) {
            return Obx(() => controller.isLoadingContacts.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListTile(
                    title: Text(controller.contacts[index].displayName),
                    onTap: () => {
                      Get.dialog(AlertDialog(
                        title: Text(controller.contacts[index].displayName),
                        content: Text(controller.contacts[index].phones.first.number
                            .toString()),
                        actions: [
                          TextButton(
                              onPressed: () => Get.back(), child: Text("Close"))
                        ],
                      ))
                    },
                    // subtitle:
                    //     Text(controller.contacts[index].phones.first.number),
                  ));
          },
        ));
  }
}
