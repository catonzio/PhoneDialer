extension SuperDateTime on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameDayTs(int timestamp) {
    DateTime other = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return isSameDay(other);
  }

  String monthToWord() {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      default:
        return "December";
    }
  }

  DateTime toDayMonthYear() {
    return DateTime(year, month, day, 0, 0, 0, 0, 0);
  }
}

bool isSameDay(int ts1, int ts2) {
  DateTime d1 = DateTime.fromMillisecondsSinceEpoch(ts1);
  DateTime d2 = DateTime.fromMillisecondsSinceEpoch(ts2);
  return d1.isSameDay(d2);
}

int compareTimestamps(int ts1, int ts2) {
  DateTime d1 = DateTime.fromMillisecondsSinceEpoch(ts1);
  DateTime d2 = DateTime.fromMillisecondsSinceEpoch(ts2);
  return d1.compareTo(d2);
  // return d1.isSameDay(d2);
}
