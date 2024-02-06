import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/list_controller.dart';
import 'package:phone_dialer/utils/extensions/context_extensions.dart';
//import '../widgets/sliver_app_bar_delegate.dart';
//import 'package:phone_dialer/widgets/sliver_app_bar_delegate.dart';

import '../widgets/sliver_app_bar_delegate.dart';

class ListPage extends StatelessWidget {
  final ListController listController;

  final String tag;
  final Widget title;
  final Widget subtitle;
  final Widget mainList;
  final Widget scrollBar;
  final Function(String) searchFunction;

  const ListPage(
      {super.key,
      required this.tag,
      required this.listController,
      required this.title,
      required this.subtitle,
      required this.mainList,
      required this.scrollBar,
      required this.searchFunction});

  SliverPersistentHeader makeHeader(BuildContext context, double height) {
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

  @override
  Widget build(BuildContext context) {
    double height = context.height / 100;

    return Stack(
      children: [
        CustomScrollView(
          controller: listController.scrollController,
          slivers: <Widget>[
            SliverFixedExtentList(
              itemExtent: height * 30,
              delegate: SliverChildListDelegate(
                [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [title, subtitle],
                    ),
                  )
                ],
              ),
            ),
            makeHeader(context, height * 8),
            // buildMainList(context),
            mainList,
          ],
        ),
        // Obx(() => listController.isScrolling
        //     ? Positioned(right: 0, top: 0, bottom: 0, child: scrollBar)
        //     : Container()),
        Positioned(right: 0, top: 0, bottom: 0, child: scrollBar),
        Obx(() => listController.isScrolling
            ? Positioned(
                bottom: 0,
                right: context.width / 2 - 25,
                left: context.width / 2 - 25,
                child: GoUpButton(listController: listController))
            : Container())
      ],
    );
  }
}

class GoUpButton extends StatelessWidget {
  final ListController listController;

  const GoUpButton({
    super.key,
    required this.listController,
  });

  @override
  Widget build(BuildContext context) {
    double width = context.width / 100;
    return Material(
      elevation: 20,
      shape: const CircleBorder(),
      child: Container(
        width: width * 10,
        height: width * 10,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          // color: Colors.grey[900],
          // border: Border.all(color: Colors.grey[700]!, width: 2),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.keyboard_double_arrow_up_sharp),
          padding: const EdgeInsets.all(0),
          onPressed: () {
            listController.isAtBottom = false;
            listController.moveAt(0);
          },
        ),
      ),
    );
  }
}
