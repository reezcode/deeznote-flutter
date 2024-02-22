import 'package:intl/intl.dart';

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
  String formattedDate = '$date $month $year ${isTimeOnly ? time : ''}';

  return formattedDate;
}
