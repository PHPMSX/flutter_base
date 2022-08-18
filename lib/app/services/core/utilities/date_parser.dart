import 'package:intl/intl.dart';

class DateParser {
  String getCurrentDateWithTimeZone() {
    DateTime now = DateTime.now();
    String dateStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    int offsetHour = now.timeZoneOffset.inHours;
    int offsetMinute = (now.timeZoneOffset.inMinutes % 60).abs();
    final numberFormat = NumberFormat('00');
    String sign = offsetHour > 0 ? '+' : '';
    dateStr += ' $sign${numberFormat.format(offsetHour)}:${numberFormat.format(offsetMinute)}';
    return dateStr;
  }
}