import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/data/controllers/list_controller.dart';
import 'package:phone_dialer/utils/extensions/super_datetime.dart';

class RegisterController extends ListController {
  List<CallLogEntry> entries = <CallLogEntry>[];

  final RxList<CallLogEntry> _entriesFiltered = <CallLogEntry>[].obs;
  List<CallLogEntry> get entriesFiltered => _entriesFiltered;
  set entriesFiltered(List<CallLogEntry> value) =>
      _entriesFiltered.value = value;

  final RxMap<DateTime, List<int>> _groups = <DateTime, List<int>>{}.obs;
  Map<DateTime, List<int>> get groups => _groups;
  set groups(Map<DateTime, List<int>> value) => _groups.value = value;

  final RxBool _isLoadingEntries = false.obs;
  bool get isLoadingEntries => _isLoadingEntries.value;
  set isLoadingEntries(bool value) => _isLoadingEntries.value = value;

  @override
  onInit() async {
    super.onInit();
    loadEntries();
    super.resetExpandableControllers(entriesFiltered);
    debounce(super.searchText, (callback) => searchEntries(callback));
  }

  void loadEntries({DateTime? dateFrom, DateTime? dateTo}) async {
    print("Loading entries");
    isLoadingEntries = true;

    dateFrom = dateFrom ?? DateTime.now().subtract(const Duration(days: 180));
    dateTo = dateTo ?? DateTime.now();

    CallLog.query(dateTimeFrom: dateFrom, dateTimeTo: dateTo).then((entries) {
      // entries.toList().sort(
      //     (a, b) => compareTimestamps(a.timestamp ?? 0, b.timestamp ?? 0));

      this.entries = entries.toList(); // entries.toList().reversed.toList();
      entriesFiltered = this.entries;
      groups = buildGroups();
      isLoadingEntries = false;

      print("Entries loaded");
    });
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
    groups = buildGroups();
  }

  void searchEntries(String text) {
    if (text.isNotEmpty) {
      entriesFiltered = entriesFiltered
          .where((CallLogEntry e) =>
              (e.number ?? "").contains(text) ||
              (e.formattedNumber ?? "").contains(text) ||
              (e.name ?? "").toLowerCase().contains(text.toLowerCase()))
          .toList();
    } else {
      entriesFiltered = entries;
    }
    groups = buildGroups();
  }

  void setNumberForCall(int index, bool isCall) {
    String num = entriesFiltered[index].number ?? "";
    if (num.isNotEmpty) {
      super.setNumber(num, isCall);
    }
  }

  @override
  void clearText() {
    super.clearText();
    searchEntries("");
  }
}
