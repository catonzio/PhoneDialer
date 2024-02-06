import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/register_controller.dart';
import 'package:phone_dialer/utils/extensions/super_datetime.dart';
import 'package:phone_dialer/ui/widgets/entry_element.dart';
import 'package:phone_dialer/ui/widgets/group_element.dart';

class EntriesGroupElement extends StatelessWidget {
  final DateTime group;

  const EntriesGroupElement({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    double height = context.height / 100;
    double width = context.width / 100;

    final RegisterController controller = Get.find<RegisterController>();
    List<int> idxs = controller.groups[group]!;

    return GroupElement(
        title: "${group.day} ${group.monthToWord()}",
        children: List.generate(
            idxs.length,
            (idx) => idx > 0
                ? [
                    Padding(
                        padding: EdgeInsets.fromLTRB(
                            12 + width * 2 + height * 4, 0, 8, 0),
                        child: const Divider()),
                    EntryElement(
                        entry: controller.entriesFiltered[idxs[idx]],
                        realIndex: idxs[idx],
                        index: idx)
                  ]
                : [
                    EntryElement(
                        entry: controller.entriesFiltered[idxs[idx]],
                        realIndex: idxs[idx],
                        index: idx)
                  ]).expand((element) => element).toList());
  }
}
