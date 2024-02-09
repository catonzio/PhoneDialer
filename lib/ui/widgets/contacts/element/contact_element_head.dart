import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';

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
        padding: EdgeInsets.symmetric(horizontal: width * 2),
        alignment: Alignment.center,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: height * 4,
                height: height * 4,
                decoration: BoxDecoration(
                    color: controller.colors[index], shape: BoxShape.circle
                    // borderRadius: const BorderRadius.all(Radius.circular(20))
                    ),
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
