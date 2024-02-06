import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';
import 'package:phone_dialer/ui/widgets/contacts_group_element.dart';

class ContactsMainList extends StatelessWidget {
  const ContactsMainList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ContactsController>(
      builder: (controller) {
        if (!controller.isLoadingContacts && controller.groups.isNotEmpty) {
          List<String> sortedGroups = controller.groups.keys.toList();
          return SliverList.builder(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedGroups.length,
            itemBuilder: (context, index) {
              String group = sortedGroups[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: ContactsGroupElement(
                  key: UniqueKey(),
                  group: group,
                ),
              );
            },
          );
        } else {
          return SliverToBoxAdapter(
              child: Center(
                  child: controller.isLoadingContacts
                      ? const CircularProgressIndicator()
                      : const Text("No contacts found")));
        }
      },
    );
  }
}
