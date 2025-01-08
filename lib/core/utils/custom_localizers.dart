import 'package:intl/intl.dart';

class CustomFormatters {
  //lang specific
  String currencyFormat(dynamic number, String currrency) {
    final formatter = NumberFormat('#,###', 'en_US');

    if (number == 0) {
      return 'Free';
    }
    try {
      if (currrency == 'USD') return "${formatter.format(number)} \$";
      return "${formatter.format(number)} SO'M";
    } catch (e) {
      throw ArgumentError('Input must be int or double');
    }
  }

  String commafy(dynamic number) {
    final formatter = NumberFormat('#,###', 'en_US');
    return formatter.format(number).toString();
  }

  String getRelativeTime(String? dateString) {
    if (dateString == null) return 'Unknown';

    DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inSeconds > 0) {
      return '${difference.inSeconds} second${difference.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }
}
