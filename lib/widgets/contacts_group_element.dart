import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/contacts_controller.dart';

class ContactsGroupElement extends StatelessWidget {
  final ContactsController controller = Get.find<ContactsController>();
  final String group;
  final Function(BuildContext, List<int>) elements;

  ContactsGroupElement(
      {super.key, required this.group, required this.elements});

  @override
  Widget build(BuildContext context) {
    List<int> idxs = controller.groups[group]!;
    double height = MediaQuery.of(context).size.height / 100;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(group, style: const TextStyle(color: Colors.white)),
          ),
          Container(
              width: double.infinity,
              height:
                  height * 6.8 * controller.groups[group]!.length.toDouble(),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ExpandableNotifier(
                child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: elements(context, idxs)),
              ))
        ]);
  }
}
