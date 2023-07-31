import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/register_controller.dart';
import 'package:phone_dialer/extensions/super_datetime.dart';

class EntriesGroupElement extends StatelessWidget {
  final RegisterController controller = Get.find<RegisterController>();
  final DateTime group;
  final Function(BuildContext, List<int>) elements;

  EntriesGroupElement({super.key, required this.group, required this.elements});

  @override
  Widget build(BuildContext context) {
    List<int> idxs = controller.groups[group]!;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("${group.day} ${group.monthToWord()}",
                style: const TextStyle(color: Colors.white)),
          ),
          Container(
              width: double.infinity,
              //height: height * 7 * controller.groups[group]!.length.toDouble(),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ExpandableNotifier(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: elements(context, idxs)),
              ))
        ]);
  }
}
