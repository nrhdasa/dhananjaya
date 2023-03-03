import 'package:intl/intl.dart';

String getDateinFormat(String date, String format) {
  DateTime dateformatted = DateTime.parse(date);
  final DateFormat formatter = DateFormat(format);
  final String formatted = formatter.format(dateformatted);
  return formatted;
}