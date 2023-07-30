import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/register_controller.dart';

class EntryElement extends StatelessWidget {
  final RegisterController controller = Get.find<RegisterController>();
  final CallLogEntry entry;
  final int index;

  EntryElement({super.key, required this.entry, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(entry.name ?? ""),
      subtitle: Text(entry.number ?? ""),
      trailing: IconButton(
          onPressed: () {
            controller.removeEntry(index);
          },
          icon: const Icon(Icons.delete)),
    );
  }
}
