import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/register_controller.dart';

class EntryElement extends StatelessWidget {
  final RegisterController controller = Get.find<RegisterController>();
  final CallLogEntry entry;
  final int index;

  late Widget leading;

  EntryElement({super.key, required this.entry, required this.index}) {
    leading = getLeading();
  }

  @override
  Widget build(BuildContext context) {
    DateTime callDt = DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0);
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.only(right: 16), child: leading),
            Text(
              entry.name ?? entry.number ?? "",
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Text("${callDt.hour}:${callDt.minute}"),
          ],
        ),
      ),
    );

    // ListTile(
    //   leading: leading,
    //   title: Text(entry.name ?? entry.number ?? ""),
    //   subtitle: Text(entry.name != null ? (entry.number ?? "") : ""),
    //   trailing: IconButton(
    //       onPressed: () {
    //         controller.removeEntry(index);
    //       },
    //       icon: const Icon(Icons.delete)),
    // );
  }

  Widget getLeading() {
    // var ct = entry.callType;
    // ct == CallType.incoming
    //     ? const Icon(Icons.phone_callback)
    //     : ct == CallType.missed
    //         ? const Icon(Icons.phone_missed)
    //         : ct == CallType.outgoing
    //             ? const Icon(Icons.phone_forwarded)
    //             : ct == CallType.rejected
    //                 ? const Icon(Icons.phone_disabled)
    //                 : ct == CallType.blocked
    //                     ? const Icon(Icons.block)
    //                     : ct == CallType.voiceMail
    //                         ? const Icon(Icons.voicemail)
    //                         : ct == CallType.answeredExternally
    //                             ? const Icon(Icons.phone_forwarded)
    //                             : Container();
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
}
