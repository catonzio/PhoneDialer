import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/list_controller.dart';

class ExpandableElement extends StatelessWidget {
  final Widget header;
  final Widget bodyFirstLine;
  final Widget bodySecondLine;
  final Widget bodyThirdLine;
  final int realIndex;
  final ListController controller;

  const ExpandableElement(
      {super.key,
      required this.header,
      required this.bodyFirstLine,
      required this.bodySecondLine,
      required this.bodyThirdLine,
      required this.realIndex,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Obx(() => Expandable(
            controller: controller.expandableControllers[realIndex],
            collapsed: GestureDetector(
              onTap: () {
                controller.updateExpandableController(realIndex, true);
                // controller.expandableControllers[realIndex].toggle();
              },
              child: header,
            ),
            expanded: GestureDetector(
                onTap: () {
                  controller.updateExpandableController(realIndex, false);
                  // controller.expandableControllers[realIndex].toggle();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header,
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 13.5, vertical: height * 1.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            bodyFirstLine,
                            bodySecondLine,
                            bodyThirdLine
                          ],
                        )),
                  ],
                )),
          )),
    );
  }
}
