import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';
import 'package:phone_dialer/ui/widgets/contacts/element/contact_element_body.dart';
import 'package:phone_dialer/ui/widgets/contacts/element/contact_element_head.dart';
import 'package:phone_dialer/ui/widgets/expandable_element.dart';
import 'package:phone_dialer/utils/utility.dart';

class ContactElement extends StatelessWidget {
  final Contact contact;
  final int index;
  final int realIndex;

  const ContactElement(
      {super.key,
      required this.contact,
      required this.index,
      required this.realIndex});

  @override
  Widget build(BuildContext context) {
    final ContactsController controller = Get.find<ContactsController>();
    Phone? obj = contact.phones.firstOrNull;
    String num = obj == null ? "" : clearPhoneNumber(obj.number);

    return ExpandableElement(
        header: ContactElementHead(index: realIndex, contact: contact),
        bodyFirstLine: Container(),
        bodySecondLine: Text("Cellulare $num",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        bodyThirdLine: ContactElementBody(realIndex: realIndex),
        realIndex: realIndex,
        controller: controller);
  }
}
