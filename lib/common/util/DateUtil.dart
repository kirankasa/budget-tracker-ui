import 'package:intl/intl.dart';

class DateUtil {
  static bool isValidDate(String transactionDate) {
    if (transactionDate.isEmpty) return true;
    var d = convertToDate(transactionDate);
    return d != null && d.isBefore(new DateTime.now());
  }

  static DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }
}
