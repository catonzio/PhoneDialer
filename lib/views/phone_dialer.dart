import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/phone_controller.dart';
import 'package:phone_dialer/views/default_page.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class PhoneDialer extends StatelessWidget {
  final PhoneController controller = Get.find<PhoneController>();
  PhoneDialer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    print("height: ${height * 100}, width: ${width * 100}");
    print(
        "rapporto: ${width / height * 100}, ${height / width * 100}, ${1080 / 720}, ${16 / 9}");

    return DefaultPage(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(width * 15, 0, width * 15, height * 4),
            child: TextField(
              showCursor: true,
              focusNode: AlwaysDisabledFocusNode(),
              controller: controller.numberController,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.displaySmall,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          AspectRatio(
            aspectRatio: 3 / 2,
            child: SizedBox(
              height: height * 50,
              child: GridView.count(
                  padding: EdgeInsets.fromLTRB(width * 6, 0, width * 6, 0),
                  childAspectRatio: 1.8,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: generateButtons(context)),
            ),
          ),
          SizedBox(
              height: height * 13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 10000),
                    child: Obx(() => IconButton(
                          key: ValueKey(controller.phoneNumber.isNotEmpty),
                          icon: Icon(Icons.delete,
                              color: controller.phoneNumber.isNotEmpty
                                  ? Colors.red[900]
                                  : Colors.transparent),
                          onPressed: () => controller.resetText(),
                        )),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: 50,
                    ),
                    onPressed: () => controller.makeCall(),
                  ),
                  Obx(() => IconButton(
                        icon: Icon(Icons.backspace,
                            color: controller.phoneNumber.isNotEmpty
                                ? Colors.red[900]
                                : Colors.transparent),
                        onPressed: () => controller.deleteChar(),
                      )),
                ],
              )),
        ],
      )),
    );
  }

  generateButtons(BuildContext context) {
    List<Widget> buttons = <Widget>[];
    for (int i = 1; i < 10; i++) {
      buttons.add(Center(
        child: TextButton(
            child: Text(
              '$i',
              style: context.theme.textTheme.headlineMedium,
              // style: const TextStyle(fontSize: 20),
            ),
            onPressed: () => controller.addNumber(i)),
      ));
    }
    buttons.add(Center(
      child: TextButton(
          child: Text(
            '*',
            style: context.theme.textTheme.headlineMedium,
          ),
          onPressed: () => controller.addNumber('*')),
    ));
    buttons.add(Center(
      child: TextButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '0',
              style: context.theme.textTheme.headlineSmall,
            ),
            Text(
              '+',
              style: context.theme.textTheme.bodyLarge,
            )
          ],
        ),
        onPressed: () => controller.addNumber(0),
        onLongPress: () => controller.addNumber('+'),
      ),
    ));
    buttons.add(Center(
      child: TextButton(
          child: Text(
            '#',
            style: context.theme.textTheme.headlineMedium,
          ),
          onPressed: () => controller.addNumber('#')),
    ));
    return buttons;
  }
}
