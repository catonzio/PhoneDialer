import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/contacts_controller.dart';
import 'package:phone_dialer/extensions/context_extensions.dart';
import 'package:phone_dialer/widgets/contact_element.dart';

class ContactsGroupElement extends StatelessWidget {
  final ContactsController controller = Get.find<ContactsController>();
  final String group;
  // final Function(BuildContext, List<int>) elements;

  ContactsGroupElement({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    List<int> idxs = controller.groups[group]!;
    // double height = MediaQuery.of(context).size.height / 100;
    return Material(
      elevation: 10,
      color: Colors.transparent,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(group),
            ),
            Container(
                decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    // color: Colors.grey[900],
                    border: Border.all(
                        // color: Colors.black,
                        ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: ExpandableNotifier(
                  child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: buildElementsList(context, idxs)),
                ))
          ]),
    );
  }

  List<Widget> buildElementsList(BuildContext context, List<int> idxs) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    List<Widget> res = <Widget>[];
    for (int i = 0; i < idxs.length; i++) {
      if (i > 0) {
        res.add(Padding(
            padding: EdgeInsets.fromLTRB(12 + width * 2 + height * 4, 0, 8, 0),
            child: const Divider()));
      }
      res.add(ContactElement(
        contact: controller.contactsFiltered[idxs[i]],
        index: i,
        realIndex: idxs[i],
      ));
    }
    return res;
  }
}
