import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/register_controller.dart';
import 'package:phone_dialer/ui/widgets/expandable_element.dart';
import 'package:phone_dialer/ui/widgets/register/element/entry_element_body.dart';
import 'package:phone_dialer/ui/widgets/register/element/entry_element_head.dart';
import 'package:phone_dialer/utils/utility.dart';

class EntryElement extends StatelessWidget {
  final CallLogEntry entry;
  final int realIndex;
  final int index;

  // late Widget leading;

  const EntryElement(
      {super.key,
      required this.entry,
      required this.realIndex,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();

    String minutes = ((entry.duration ?? 0) ~/ 60).toString().padLeft(2, '0');
    String seconds = ((entry.duration ?? 0) % 60).toString().padLeft(2, '0');

    Widget bodyFirstLine = entry.name != null
        ? Text("Cellulare ${clearPhoneNumber(entry.number ?? "")}",
            style: const TextStyle(fontWeight: FontWeight.bold))
        : Container();
    Widget bodySecondLine =
        Text("${entry.callType?.name.capitalizeFirst ?? ''} $minutes:$seconds");

    return ExpandableElement(
        header: EntryElementHead(
          entry: entry,
        ),
        bodyFirstLine: bodyFirstLine,
        bodySecondLine: bodySecondLine,
        bodyThirdLine: EntryElementBody(realIndex: realIndex),
        realIndex: realIndex,
        controller: controller);
  }
}
