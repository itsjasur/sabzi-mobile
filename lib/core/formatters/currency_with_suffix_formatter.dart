import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatterWithSuffix extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,##0", "en_US");
  static const int _maxValue = 9999999999;
  final String currencyName;

  CurrencyInputFormatterWithSuffix({required this.currencyName});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // removes all non-digit characters, currency name
    String value = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // If empty, return empty text value
    if (value.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Parse the number and limit to max value
    int number = int.parse(value);
    if (number > _maxValue) {
      number = _maxValue;
    }

    // Format the number with thousands separator and add currencyName prefix
    final formattedText = '$currencyName ${_formatter.format(number)}';

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  // Helper method to get clean numeric value
  static int? getCleanNumber(String text) {
    if (text.isEmpty) return null;
    final value = text.replaceAll(RegExp(r'[^\d]'), '');
    return value.isEmpty ? null : int.parse(value);
  }
}
