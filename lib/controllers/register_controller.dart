import 'package:call_log/call_log.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  List<CallLogEntry> entries = <CallLogEntry>[];
  RxBool isLoadingEntries = false.obs;

  @override
  onInit() async {
    loadEntries();
    super.onInit();
  }

  void loadEntries() async {
    print("Loading entries");
    isLoadingEntries.value = true;
    entries = (await CallLog.get()).toList().obs;
    isLoadingEntries.value = false;
    print("Entries loaded");
  }

  void removeEntry(int index) {
    entries.removeAt(index);
  }
}