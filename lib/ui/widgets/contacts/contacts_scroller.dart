import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/configs/themes.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';

class ContactsScroller extends StatelessWidget {
  const ContactsScroller({super.key});

  @override
  Widget build(BuildContext context) {
    ContactsController contactsController = Get.find<ContactsController>();
    List<String> groupsLetter = contactsController.groups.keys.toList();

    double width = context.width / 100;

    return Container(
      width: width * 5,
      height: double.infinity,
      decoration: BoxDecoration(
        color: dividerGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 100,
            child: Container(
              width: width * 5,
              height: width * 6,
              decoration: BoxDecoration(
                  color: yellow.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  groupsLetter.length,
                  (index) => Container(
                        height: width * 0.5,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ))),
        ],
      ),
    );
  }
}
