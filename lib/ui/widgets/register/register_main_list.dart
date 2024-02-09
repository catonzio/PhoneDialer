import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/register_controller.dart';
import 'package:phone_dialer/ui/widgets/register/element/entries_group_element.dart';

class RegisterMainList extends StatelessWidget {
  const RegisterMainList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<RegisterController>(builder: (controller) {
      if (!controller.isLoadingEntries && controller.groups.isNotEmpty) {
        List<DateTime> sortedGroups = controller.groups.keys.toList();
        return SliverList.builder(
          itemCount: sortedGroups.length,
          itemBuilder: (context, index) {
            DateTime group = sortedGroups[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: EntriesGroupElement(
                key: UniqueKey(),
                group: group,
              ),
            );
          },
        );
      } else {
        return SliverToBoxAdapter(
          child: Center(
            child: controller.entries.isEmpty
                ? const Text("No call logs found")
                : const CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
