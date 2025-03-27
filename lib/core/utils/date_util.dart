import 'package:intl/intl.dart';

/// Utility class for handling date formatting.
class DateUtil {
  /// Formats a given [dateString] to 'dd/MM/yyyy'.
  static String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'Unknown';
    }
    final date = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
