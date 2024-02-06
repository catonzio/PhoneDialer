import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/utils/utility.dart';

import 'settings_controller.dart';

class PhoneController extends GetxController {
  final RxString _phoneNumber = "".obs;
  String get phoneNumber => _phoneNumber.value;
  set phoneNumber(String value) => _phoneNumber.value = value;

  TextEditingController numberController = TextEditingController();
  int lastCursorPos = -1;

  @override
  void onInit() {
    numberController.text = phoneNumber;
    super.onInit();
  }

  @override
  dispose() {
    numberController.dispose();
    super.dispose();
  }

  setText(String text) {
    text = clearPhoneNumber(text);
    phoneNumber = text;
    numberController.text = phoneNumber;
  }

  resetText() {
    print("Resetting text");
    setText("");
  }

  deleteChar() {
    print("Deleting char");
    if (phoneNumber.isEmpty || numberController.selection.baseOffset == 0) {
      return;
    }
    if (numberController.selection.baseOffset != lastCursorPos) {
      lastCursorPos = numberController.selection.baseOffset;
    }
    if (lastCursorPos == -1) {
      phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
    } else {
      phoneNumber = phoneNumber.substring(0, lastCursorPos - 1) +
          (lastCursorPos < phoneNumber.length
              ? phoneNumber.substring(lastCursorPos)
              : '0');
      lastCursorPos--;
    }
    // phoneNumber =
    //     phoneNumber.substring(0, phoneNumber.length - 1);
    numberController.text = phoneNumber;
  }

  addNumber(dynamic number) {
    // TODO: fix cursor position
    int idx = numberController.selection.baseOffset;
    String n = number.toString();
    if (idx == 0) {
      // the cursor is at the beginning
      phoneNumber = n + phoneNumber;
    } else if (idx < 0) {
      // the cursor is at the end
      phoneNumber = phoneNumber + n;
      lastCursorPos = -1;
    } else if (idx > 0) {
      if (lastCursorPos != -1) {
        idx = lastCursorPos;
      }
      // the cursor is in the middle
      phoneNumber =
          phoneNumber.substring(0, idx) + n + phoneNumber.substring(idx);
      lastCursorPos = idx;
    }
    numberController.text = phoneNumber;
  }

  makeCall() async {
    if (phoneNumber.isEmpty) return;

    SettingsController currentSettings = Get.find<SettingsController>();
    String number = '${currentSettings.prefix}${numberController.text},9';
    print(number);
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    if (res == null || !res) {
      Get.snackbar("Error", "Could not make call");
    }
  }
}
