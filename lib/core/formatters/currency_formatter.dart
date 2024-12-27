import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    try {
      final number = double.parse(newValue.text.replaceAll(',', ''));
      final formatter = NumberFormat('#,##0', 'en_US');
      String formattedNumber = formatter.format(number);
      return TextEditingValue(
        text: formattedNumber,
        selection: TextSelection.collapsed(offset: formattedNumber.length),
      );
    } catch (e) {
      // Handle invalid input (e.g., non-numeric characters)
      return oldValue;
    }
  }
}
