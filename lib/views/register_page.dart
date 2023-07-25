import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/register_controller.dart';
import 'package:phone_dialer/views/default_page.dart';

import 'tab_page.dart';

class RegisterPage extends TabPage {
  final RegisterController controller = Get.put(RegisterController());
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => controller.isLoadingEntries.value
            ? const Center(child: CircularProgressIndicator())
            : (controller.entries.isEmpty
                ? const Center(child: Text("There are no call logs"))
                : Expanded(
                    child: Obx(() => ListView.builder(
                        itemCount: controller.entries.length,
                        itemBuilder: (context, index) {
                          return CallEntryWidget(
                              entry: controller.entries[index], index: index);
                        })))))
      ],
    );
  }
}

class CallEntryWidget extends StatelessWidget {
  final RegisterController controller = Get.find<RegisterController>();
  final CallLogEntry entry;
  final int index;

  CallEntryWidget({super.key, required this.entry, required this.index});

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          ListTile(
            title: Text(entry.name ?? ""),
            subtitle: Text(entry.number ?? ""),
            trailing: IconButton(
                onPressed: () {
                  controller.removeEntry(index);
                },
                icon: const Icon(Icons.delete)),
          )
        ],
      );
    } else {
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
}
