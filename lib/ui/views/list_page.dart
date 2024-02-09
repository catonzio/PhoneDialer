import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/list_controller.dart';
import 'package:phone_dialer/ui/widgets/go_up_button.dart';
import 'package:phone_dialer/ui/widgets/list_page_header.dart';

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

  @override
  Widget build(BuildContext context) {
    double height = context.height / 100;
    double titleHeight = height * 30;
    double headerHeight = height * 8;
    Duration animationDuration = const Duration(milliseconds: 200);

    return Stack(
      children: [
        CustomScrollView(
          controller: listController.scrollController,
          slivers: <Widget>[
            SliverFixedExtentList(
              itemExtent: titleHeight,
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
            ListPageHeader(
                height: headerHeight, listController: listController),
            mainList,
          ],
        ),
        Obx(() => Positioned(
              right: 0,
              top: headerHeight,
              bottom: 0,
              child: AnimatedSwitcher(
                duration: animationDuration,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: listController.scrollOffset >= titleHeight
                    ? scrollBar
                    : const SizedBox.shrink(),
              ),
            )),
        Obx(() => Positioned(
            bottom: 0,
            right: context.width / 2 - 25,
            left: context.width / 2 - 25,
            child: AnimatedSwitcher(
              duration: animationDuration,
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: listController.scrollOffset >= titleHeight
                  ? GoUpButton(listController: listController)
                  : const SizedBox.shrink(),
            )))
      ],
    );
  }
}
