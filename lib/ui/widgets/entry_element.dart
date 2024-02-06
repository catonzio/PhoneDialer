import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/register_controller.dart';
import 'package:phone_dialer/utils/utility.dart';

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

    String minutes = ((entry.duration ?? 0) ~/ 60).toString().padLeft(2, '0');
    String seconds = ((entry.duration ?? 0) % 60).toString().padLeft(2, '0');

    Widget bodyFirstLine = entry.name != null
        ? Text("Cellulare ${clearPhoneNumber(entry.number ?? "")}",
            style: const TextStyle(fontWeight: FontWeight.bold))
        : Container();
    Widget bodySecondLine =
        Text("${entry.callType?.name.capitalizeFirst ?? ''} $minutes:$seconds");

    return ExpandableElement(
        header: EntryElementHeader(
          entry: entry,
        ),
        bodyFirstLine: bodyFirstLine,
        bodySecondLine: bodySecondLine,
        bodyThirdLine: EntryElementBody(realIndex: realIndex),
        realIndex: realIndex,
        controller: controller);
  }
}

class EntryElementHeader extends StatelessWidget {
  final CallLogEntry entry;

  const EntryElementHeader({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    DateTime callDt = DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.only(right: 16), child: getLeading()),
          Text(
            entry.name ?? clearPhoneNumber(entry.number ?? ""),
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(),
          Text(
              "${callDt.hour.toString().padLeft(2, '0')}:${callDt.minute.toString().padLeft(2, '0')}"),
        ],
      ),
    );
  }

  Widget getLeading() {
    const Map<CallType, Icon> callsMapIcons = {
      CallType.incoming: Icon(Icons.phone_callback),
      CallType.missed: Icon(Icons.phone_missed),
      CallType.outgoing: Icon(Icons.phone_forwarded),
      CallType.rejected: Icon(Icons.phone_disabled),
      CallType.blocked: Icon(Icons.block),
      CallType.voiceMail: Icon(Icons.voicemail),
      CallType.answeredExternally: Icon(Icons.phone_forwarded),
    };
    return callsMapIcons[entry.callType] ?? Container();
  }
}

class EntryElementBody extends StatelessWidget {
  final int realIndex;

  const EntryElementBody({super.key, required this.realIndex});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();
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
