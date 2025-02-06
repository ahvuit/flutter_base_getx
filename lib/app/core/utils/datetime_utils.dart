import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDate(DateTime date, {String pattern = 'dd/MM/yyyy'}) {
    final formatter = DateFormat(pattern);
    final formatted = formatter.format(date);
    return formatted;
  }

  static DateTime parseDate(String date, {String pattern = 'dd/MM/yyyy'}) {
    final formatter = DateFormat(pattern);
    final parsed = formatter.parse(date);
    return parsed;
  }

  static String getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}