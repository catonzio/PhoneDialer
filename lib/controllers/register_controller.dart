import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/controllers/list_controller.dart';
import 'package:phone_dialer/extensions/super_datetime.dart';

class RegisterController extends ListController {
  List<CallLogEntry> entries = <CallLogEntry>[];
  List<CallLogEntry> entriesFiltered = <CallLogEntry>[].obs;
  RxMap<DateTime, List<int>> groups = <DateTime, List<int>>{}.obs;
  RxBool isLoadingEntries = false.obs;

  @override
  onInit() async {
    loadEntries();
    super.resetExpandableControllers(entriesFiltered);
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadEntries({DateTime? dateFrom, DateTime? dateTo}) async {
    print("Loading entries");
    isLoadingEntries.value = true;

    dateFrom = dateFrom ?? DateTime.now().subtract(const Duration(days: 5));
    dateTo = dateTo ?? DateTime.now();

    List<CallLogEntry> entries =
        (await CallLog.query(dateTimeFrom: dateFrom, dateTimeTo: dateTo))
            .toList()
            .obs;
    entries
        .sort((a, b) => compareTimestamps(a.timestamp ?? 0, b.timestamp ?? 0));

    this.entries = entries.reversed.toList();
    entriesFiltered = this.entries;
    groups.value = buildGroups();
    isLoadingEntries.value = false;

    print("Entries loaded");
  }

  Map<DateTime, List<int>> buildGroups() {
    Map<DateTime, List<int>> groups = {};
    for (int i = 0; i < entriesFiltered.length; i++) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(entriesFiltered[i].timestamp ?? 0)
              .toDayMonthYear();
      if (groups.containsKey(date)) {
        groups[date]!.add(i);
      } else {
        groups[date] = [i];
      }
    }
    // isExpanded = List<bool>.filled(groups.length, false).obs;
    super.resetExpandableControllers(entriesFiltered);
    return groups;
  }

  void removeEntry(int index) {
    entriesFiltered.removeAt(index);
    groups.value = buildGroups();
  }

  void searchEntries(String test) {
    if (test.isNotEmpty) {
      entriesFiltered = entriesFiltered
          .where((CallLogEntry e) =>
              (e.formattedNumber ?? "").contains(test) ||
              (e.name ?? "").toLowerCase().contains(test.toLowerCase()))
          .toList();
    } else {
      entriesFiltered = entries;
    }
    groups.value = buildGroups();
  }

  void setNumberForCall(int index, bool isCall) {
    String num = entriesFiltered[index].number ?? "";
    if (num.isNotEmpty) {
      super.setNumber(num, isCall);
    }
  }
}
