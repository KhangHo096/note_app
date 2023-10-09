import 'package:intl/intl.dart';

class DateTimeUtils {
  final defaultFormat = DateFormat("HH:mm - dd/MM/yyyy");

  String formatDate(DateTime date) {
    return defaultFormat.format(date);
  }
}