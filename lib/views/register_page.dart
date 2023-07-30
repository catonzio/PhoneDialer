import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/register_controller.dart';
import 'package:phone_dialer/views/default_page.dart';
import 'package:phone_dialer/views/list_page.dart';
import 'package:phone_dialer/widgets/entries_group_element.dart';
import 'package:phone_dialer/widgets/entry_element.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
        body: ListPage(
      tag: "register",
      title: const Text(
        "Call logs",
        style: TextStyle(fontSize: 50.0, color: Colors.white),
      ),
      subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "There are ${controller.entries.length} call logs",
            style: const TextStyle(fontSize: 15.0, color: Colors.white),
          )),
      mainList: buildMainList(context),
      scrollBar: Container(),
      searchFunction: (String text) => controller.searchEntries(text),
    ));
  }

  Widget buildMainList(BuildContext context) {
    return Obx(() => controller.isLoadingEntries.value
        ? const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SliverToBoxAdapter(
            child: Column(children: [
              for (DateTime group in controller.groups.keys.toList()..sort())
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: EntriesGroupElement(
                      group: group, elements: buildElementsList),
                )
              // for (int i = 0; i < controller.entries.length; i++)
              //   Padding(
              //       padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              //       child:
              //           CallEntryWidget(entry: controller.entries[i], index: i))
            ]),
          ));
  }

  List<Widget> buildElementsList(BuildContext context, List<int> idxs) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    List<Widget> res = <Widget>[];
    for (int i = 0; i < idxs.length; i++) {
      if (i > 0) {
        res.add(Padding(
            padding: EdgeInsets.fromLTRB(12 + width * 2 + height * 4, 0, 8, 0),
            child: const Divider()));
      }
      res.add(EntryElement(entry: controller.entries[idxs[i]], index: i));
    }
    return res;
  }
}
