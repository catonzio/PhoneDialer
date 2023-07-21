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
    return DefaultPage(
        title: "Phone",
        showSettingsButton: true,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SizedBox(height: 200,),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.38,
              child: GridView.count(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  childAspectRatio: 1.5,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: generateButtons()),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red[900]),
                      onPressed: () => controller.resetText(),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.green,
                        size: 50,
                      ),
                      onPressed: () => controller.makeCall(),
                    ),
                    IconButton(
                      icon: Icon(Icons.backspace, color: Colors.red[900]),
                      onPressed: () => controller.deleteChar(),
                    ),
                  ],
                )
                /*child: GridView.count(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red[900]),
                    onPressed: () => controller.resetText(),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: 50,
                    ),
                    onPressed: controller.makeCall(),
                  ),
                  IconButton(
                    icon: Icon(Icons.backspace, color: Colors.red[900]),
                    onPressed: () => controller.deleteChar(),
                  ),
                ],
              ),*/
                ),
          ],
        )));
  }

  generateButtons() {
    List<Widget> buttons = <Widget>[];
    for (int i = 1; i < 10; i++) {
      buttons.add(Center(
        child: MaterialButton(
            child: Text(
              '$i',
              style: const TextStyle(fontSize: 30),
            ),
            onPressed: () => controller.addNumber(i)),
      ));
    }
    buttons.add(Center(
      child: MaterialButton(
          child: const Text(
            '*',
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () => controller.addNumber('*')),
    ));
    buttons.add(Center(
      child: MaterialButton(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '0',
              style: TextStyle(fontSize: 30),
            ),
            Text('+')
          ],
        ),
        onPressed: () => controller.addNumber(0),
        onLongPress: () => controller.addNumber('+'),
      ),
    ));
    buttons.add(Center(
      child: MaterialButton(
          child: const Text(
            '#',
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () => controller.addNumber('#')),
    ));
    return buttons;
  }
}
