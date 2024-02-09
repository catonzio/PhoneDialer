import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/list_controller.dart';
import 'package:phone_dialer/ui/widgets/sliver_app_bar_delegate.dart';
import 'package:phone_dialer/utils/extensions/context_extensions.dart';

class ListPageHeader extends StatelessWidget {
  final double height;
  final ListController listController;

  const ListPageHeader({
    super.key,
    required this.height,
    required this.listController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
          minHeight: height,
          maxHeight: height,
          child: Container(
            color: context.colorScheme.background,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => listController.isSearching
                      ? Expanded(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                              child: TextField(
                                  autofocus: true,
                                  onChanged: (text) {
                                    listController.searchText.value = text;
                                  }, // searchFunction(text),

                                  decoration: InputDecoration(
                                      hintText: "Search",
                                      prefixIcon: IconButton(
                                          onPressed: () =>
                                              listController.clearText(),
                                          icon: const Icon(
                                              Icons.cancel_outlined))))))
                      : Container()),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      listController.isSearching = !listController.isSearching;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ]),
          )),
    );
  }
}
