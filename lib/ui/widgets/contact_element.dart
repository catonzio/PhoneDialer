import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';
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

class ContactElementHead extends StatelessWidget {
  final int index;
  final Contact contact;

  const ContactElementHead(
      {super.key, required this.index, required this.contact});

  @override
  Widget build(BuildContext context) {
    final ContactsController controller = Get.find<ContactsController>();

    double height = context.height / 100;
    double width = context.width / 100;

    return Container(
        padding:
            EdgeInsets.symmetric(horizontal: width * 2, vertical: height * 1),
        alignment: Alignment.center,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: height * 4,
                height: height * 4,
                decoration: BoxDecoration(
                    color: controller.colors[index],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Text(
                    contact.displayName[0],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                child: Text(contact.displayName),
              ),
            ]));
  }
}

class ContactElementBody extends StatelessWidget {
  final int realIndex;

  const ContactElementBody({super.key, required this.realIndex});

  @override
  Widget build(BuildContext context) {
    final ContactsController controller = Get.find<ContactsController>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.green),
              child: IconButton(
                  onPressed: () => controller.setNumberForCall(realIndex, true),
                  icon: const Icon(Icons.phone))),
          Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey),
              child: IconButton(
                  onPressed: () =>
                      controller.setNumberForCall(realIndex, false),
                  icon: const Icon(Icons.copy))),
          Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
              child: IconButton(
                  onPressed: () => {}, //controller.removeEntry(realIndex),
                  icon: const Icon(Icons.mode))),
        ],
      ),
    );
  }
}
