import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/contacts_controller.dart';
import 'dart:math' as math;

import 'package:phone_dialer/widgets/expandable_element.dart';

class ContactElement extends StatelessWidget {
  final ContactsController controller = Get.find<ContactsController>();
  final Contact contact;
  final int index;
  final int realIndex;

  ContactElement(
      {super.key,
      required this.contact,
      required this.index,
      required this.realIndex});

  @override
  Widget build(BuildContext context) {
    Phone? obj = contact.phones.firstOrNull;
    String num = obj == null ? "" : obj.number;
    return ExpandableElement(
        header: buildHeader(context),
        bodyFirstLine: Container(),
        bodySecondLine: Text("Cellulare ${num}",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        bodyThirdLine: buildBody(context),
        realIndex: realIndex,
        controller: controller);
  }

  Widget buildHeader(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;

    return Container(
        // color: Colors.red[(index+1)*50 % 900],
        padding: EdgeInsets.symmetric(horizontal: width * 2),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: height * 4,
                height: height * 4,
                decoration: BoxDecoration(
                    // color: Colors.grey[900],
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Text(
                    contact.displayName[0],
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                child: Text(contact.displayName),
              ),
            ]));
  }

  Widget buildBody(BuildContext context) {
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
