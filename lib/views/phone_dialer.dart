import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/phone_controller.dart';
import 'package:phone_dialer/views/default_page.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class PhoneDialer extends StatelessWidget {
  final PhoneController controller = Get.put(PhoneController());
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
          //SizedBox(height: 200,),
          Padding(
            padding: EdgeInsets.fromLTRB(width * 15, 0, width * 15, height * 4),
            child: TextField(
              showCursor: true,
              focusNode: AlwaysDisabledFocusNode(),
              controller: controller.numberController,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30),
              decoration: const InputDecoration(),
            ),
          ),
          AspectRatio(
            aspectRatio: 3 / 2,
            child: SizedBox(
              height: height * 40,
              child: GridView.count(
                  padding: EdgeInsets.fromLTRB(width * 15, 0, width * 15, 0),
                  childAspectRatio: 1.5,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: generateButtons()),
            ),
          ),
          SizedBox(
              height: height * 13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 10000),
                    child: Obx(() => IconButton(
                          key:
                              ValueKey(controller.phoneNumber.value.isNotEmpty),
                          icon: Icon(Icons.delete,
                              color: controller.phoneNumber.value.isNotEmpty
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
                            color: controller.phoneNumber.value.isNotEmpty
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

  generateButtons() {
    List<Widget> buttons = <Widget>[];
    for (int i = 1; i < 10; i++) {
      buttons.add(Center(
        child: TextButton(
            child: Text(
              '$i',
              style: const TextStyle(fontSize: 20),
            ),
            onPressed: () => controller.addNumber(i)),
      ));
    }
    buttons.add(Center(
      child: TextButton(
          child: const Text(
            '*',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () => controller.addNumber('*')),
    ));
    buttons.add(Center(
      child: TextButton(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '0',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '+',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
        onPressed: () => controller.addNumber(0),
        onLongPress: () => controller.addNumber('+'),
      ),
    ));
    buttons.add(Center(
      child: TextButton(
          child: const Text(
            '#',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () => controller.addNumber('#')),
    ));
    return buttons;
  }
}
