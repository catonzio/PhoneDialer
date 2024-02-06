import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/register_controller.dart';

import 'expandable_element.dart';

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
    Widget bodyThirdLine = buildBody(context, controller);

    return ExpandableElement(
        header: header,
        bodyFirstLine: bodyFirstLine,
        bodySecondLine: bodySecondLine,
        bodyThirdLine: bodyThirdLine,
        realIndex: realIndex,
        controller: controller);
  }

  Widget getLeading() {
    Map<CallType, Icon> callsMapIcons = {
      CallType.incoming: const Icon(Icons.phone_callback),
      CallType.missed: const Icon(Icons.phone_missed),
      CallType.outgoing: const Icon(Icons.phone_forwarded),
      CallType.rejected: const Icon(Icons.phone_disabled),
      CallType.blocked: const Icon(Icons.block),
      CallType.voiceMail: const Icon(Icons.voicemail),
      CallType.answeredExternally: const Icon(Icons.phone_forwarded),
    };
    return callsMapIcons[entry.callType] ?? Container();
  }

  Widget buildHeader(BuildContext context, DateTime callDt) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.only(right: 16), child: getLeading()),
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

  Widget buildBody(BuildContext context, RegisterController controller) {
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
