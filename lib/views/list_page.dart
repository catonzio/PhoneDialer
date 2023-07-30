import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/list_controller.dart';
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

  ListPage(
      {super.key,
      required this.tag,
      required this.title,
      required this.subtitle,
      required this.mainList,
      required this.scrollBar,
      required this.searchFunction})
      : listController = Get.put(ListController(), tag: tag);

  SliverPersistentHeader makeHeader(String headerText, double height) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
          minHeight: height,
          maxHeight: height,
          child: Container(
              color: Colors.black,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Obx(() => listController.isSearching.value
                    ? Expanded(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                            child: TextField(
                                controller: listController.searchController,
                                onChanged: (text) => searchFunction(text),
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    hintText: "Search",
                                    prefixIcon: Icon(Icons.search)))))
                    : Container()),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    listController.isSearching.value =
                        !listController.isSearching.value;
                    print(
                        "Search button pressed: ${listController.isSearching.value}");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    print("More button pressed");
                  },
                ),
              ]))),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;

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
                      children: [
                        title,
                        subtitle
                        // Text(
                        //   title,
                        //   style: const TextStyle(
                        //       fontSize: 50.0, color: Colors.white),
                        // ),
                        // Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text(
                        //       subtitle,
                        //       style: const TextStyle(
                        //           fontSize: 15.0, color: Colors.white),
                        //     ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            makeHeader('Header Section 2', height * 8),
            // buildMainList(context),
            mainList,
          ],
        ),
        Obx(() => listController.isScrolling.value
            ? Positioned(right: 0, top: 0, bottom: 0, child: scrollBar)
            : Container()),
        Obx(() => listController.isAtBottom.value
            ? Positioned(
                bottom: 0,
                right: MediaQuery.of(context).size.width / 2 - 25,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: () {
                      listController.isAtBottom.value = false;
                      listController.moveAt(0);
                    },
                  ),
                ))
            : Container())
      ],
    );
  }
}
