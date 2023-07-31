import 'package:call_log/call_log.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/list_controller.dart';
import 'package:phone_dialer/controllers/register_controller.dart';

import 'expandable_element.dart';

class EntryElement extends StatelessWidget {
  final RegisterController controller = Get.find<RegisterController>();
  final CallLogEntry entry;
  final int realIndex;
  final int index;

  late Widget leading;

  EntryElement(
      {super.key,
      required this.entry,
      required this.realIndex,
      required this.index}) {
    leading = getLeading();
  }

  @override
  Widget build(BuildContext context) {
    DateTime callDt = DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0);
    String minutes = ((entry.duration ?? 0) ~/ 60).toString().padLeft(2, '0');
    String seconds = ((entry.duration ?? 0) % 60).toString().padLeft(2, '0');

    Widget header = buildHeader(context, callDt);
    Widget bodyFirstLine = entry.name != null
        ? Text("Cellulare ${entry.number ?? ""}",
            style: const TextStyle(fontWeight: FontWeight.bold))
        : Container();
    Widget bodySecondLine =
        Text("${entry.callType.toString()} $minutes:$seconds");
    Widget bodyThirdLine = buildBody(context);

    return ExpandableElement(
        header: header,
        bodyFirstLine: bodyFirstLine,
        bodySecondLine: bodySecondLine,
        bodyThirdLine: bodyThirdLine,
        realIndex: realIndex,
        controller: controller);
  }

  Widget getLeading() {
    switch (entry.callType) {
      case CallType.incoming:
        return const Icon(Icons.phone_callback);
      case CallType.missed:
        return const Icon(Icons.phone_missed);
      case CallType.outgoing:
        return const Icon(Icons.phone_forwarded);
      case CallType.rejected:
        return const Icon(Icons.phone_disabled);
      case CallType.blocked:
        return const Icon(Icons.block);
      case CallType.voiceMail:
        return const Icon(Icons.voicemail);
      case CallType.answeredExternally:
        return const Icon(Icons.phone_forwarded);
      default:
        return Container();
    }
  }

  Widget buildHeader(BuildContext context, DateTime callDt) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.only(right: 16), child: leading),
          Text(
            entry.name ?? entry.number ?? "",
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(),
          Text(
              "${callDt.hour.toString().padLeft(2, '0')}:${callDt.minute.toString().padLeft(2, '0')}"),
        ],
      ),
    );
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
                  onPressed: () => controller.removeEntry(realIndex),
                  icon: const Icon(Icons.delete))),
        ],
      ),
    );
  }
}

