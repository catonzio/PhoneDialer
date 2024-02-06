import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';
import 'package:phone_dialer/ui/widgets/contact_element.dart';
import 'package:phone_dialer/ui/widgets/group_element.dart';

class ContactsGroupElement extends StatelessWidget {
  final String group;

  const ContactsGroupElement({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    double height = context.height / 100;
    double width = context.width / 100;

    final ContactsController controller = Get.find<ContactsController>();
    List<int> idxs = controller.groups[group]!;

    return GroupElement(
        title: group,
        children: List.generate(
            idxs.length,
            (idx) => idx > 0
                ? [
                    Padding(
                        padding: EdgeInsets.fromLTRB(
                            12 + width * 2 + height * 4, 0, 8, 0),
                        child: const Divider()),
                    ContactElement(
                        contact: controller.contactsFiltered[idxs[idx]],
                        realIndex: idxs[idx],
                        index: idx)
                  ]
                : [
                    ContactElement(
                        contact: controller.contactsFiltered[idxs[idx]],
                        realIndex: idxs[idx],
                        index: idx)
                  ]).expand((element) => element).toList());
  }
}
