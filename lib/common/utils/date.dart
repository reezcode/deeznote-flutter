class DateHelper {
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool isGreater(DateTime date1, DateTime date2) {
    return date1.isAfter(date2);
  }

  DateTime stringToDate(String date) {
    return DateTime.parse(date);
  }
}
