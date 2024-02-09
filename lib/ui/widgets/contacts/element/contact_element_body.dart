import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';

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
