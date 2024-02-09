import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/configs/themes.dart';
import 'package:phone_dialer/data/controllers/list_controller.dart';

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
        decoration: BoxDecoration(
          // color: Colors.grey[900],
          border: Border.all(color: dividerGrey, width: 2),
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
