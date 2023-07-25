import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_controller.dart';

class PhoneController extends GetxController {
  RxString phoneNumber = "123".obs;
  TextEditingController numberController = TextEditingController();
  int lastCursorPos = -1;

  @override
  void onInit() {
    numberController.text = phoneNumber.value;
    super.onInit();
  }

  @override
  dispose() {
    numberController.dispose();
    super.dispose();
  }

  setText(String text) {
    phoneNumber.value = text;
    numberController.text = phoneNumber.value;
  }

  resetText() {
    print("Resetting text");
    phoneNumber.value = "";
    numberController.text = phoneNumber.value;
  }

  deleteChar() {
    print("Deleting char");
    if (phoneNumber.value.isEmpty || numberController.selection.baseOffset == 0)
      return;
    if (numberController.selection.baseOffset != lastCursorPos) {
      lastCursorPos = numberController.selection.baseOffset;
    }
    if (lastCursorPos == -1) {
      phoneNumber.value =
          phoneNumber.value.substring(0, phoneNumber.value.length - 1);
    } else {
      phoneNumber.value = phoneNumber.value.substring(0, lastCursorPos - 1) +
          (lastCursorPos < phoneNumber.value.length
              ? phoneNumber.value.substring(lastCursorPos)
              : '0');
      lastCursorPos--;
    }
    // phoneNumber.value =
    //     phoneNumber.value.substring(0, phoneNumber.value.length - 1);
    numberController.text = phoneNumber.value;
  }

  addNumber(dynamic number) {
    // TODO: fix cursor position
    int idx = numberController.selection.baseOffset;
    String n = number.toString();
    if (idx == 0) {
      // the cursor is at the beginning
      phoneNumber.value = n + phoneNumber.value;
    } else if (idx < 0) {
      // the cursor is at the end
      phoneNumber.value = phoneNumber.value + n;
      lastCursorPos = -1;
    } else if (idx > 0) {
      if (lastCursorPos != -1) {
        idx = lastCursorPos;
      }
      // the cursor is in the middle
      phoneNumber.value = phoneNumber.value.substring(0, idx) +
          n +
          phoneNumber.value.substring(idx);
      lastCursorPos = idx;
    }
    numberController.text = phoneNumber.value;
  }

  makeCall() {
    SettingsController currentSettings = Get.find<SettingsController>();
    String number = '${currentSettings.prefix}${numberController.text},9';
    // String number = '${numberController.text},9';
    print(number);
    // launchUrl(Uri.parse('tel://$number'));
  }
}
