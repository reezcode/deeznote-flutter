import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

String formatDate(DateTime date) {
  return DateFormat('dd MMMM yyyy').format(date);
}

String formatDateTime(String input, bool isTimeOnly) {
  DateTime dateTime = DateTime.parse(input).toLocal();

  // String day = DateFormat.EEEE().format(dateTime); // Hari
  String date = DateFormat.d().format(dateTime); // Tanggal
  String month = DateFormat.MMMM().format(dateTime); // Bulan
  String year = DateFormat.y().format(dateTime); // Tahun
  String time = DateFormat.Hm().format(dateTime); // Jam dan menit
  // Jam dan menit
  String formattedDate =
      '$date $month $year   ${isTimeOnly ? '$time WIB' : ''}';

  return formattedDate;
}

String formatTime(String input) {
  DateTime dateTime = DateTime.parse(input).toLocal();
  String time = DateFormat.Hm().format(dateTime); // Jam dan menit
  return "$time WIB";
}

int differenceInDays(
  String date2,
  DateTime date1,
) {
  DateTime dateTime2 = DateTime.parse(date2);
  return dateTime2.difference(date1).inDays;
}

String getStatusText(int dayLeft, String rawDate, int statusCode) {
  if (dayLeft == 0 && isSameDay(DateTime.now(), DateTime.parse(rawDate))) {
    return "Today";
  } else if (dayLeft == 1 ||
      (dayLeft == 0 && !isSameDay(DateTime.now(), DateTime.parse(rawDate)))) {
    return "Tomorrow";
  } else if (dayLeft < 0) {
    if (statusCode < 2) {
      return "Late";
    } else if (statusCode == 2) {
      return "Finished";
    }
  }
  return "$dayLeft day left";
}
