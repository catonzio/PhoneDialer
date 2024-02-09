import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:phone_dialer/configs/themes.dart';
import 'package:phone_dialer/utils/utility.dart';

class EntryElementHead extends StatelessWidget {
  final CallLogEntry entry;

  const EntryElementHead({super.key, required this.entry});

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
    const Map<CallType, IconData> callsMapIcons = {
      CallType.incoming: Icons.phone_callback,
      CallType.missed: Icons.phone_missed,
      CallType.outgoing: Icons.phone_forwarded,
      CallType.rejected: Icons.phone_disabled,
      CallType.blocked: Icons.block,
      CallType.voiceMail: Icons.voicemail,
      CallType.answeredExternally: Icons.phone_forwarded,
    };
    return Icon(
      callsMapIcons[entry.callType],
      color: yellow,
    );
  }
}
