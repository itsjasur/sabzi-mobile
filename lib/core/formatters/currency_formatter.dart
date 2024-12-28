import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  static const int _maxValue = 9999999999;

  CurrencyTextInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    try {
      int number = int.parse(newValue.text.replaceAll(',', ''));

      // limits to max value
      if (number > _maxValue) number = _maxValue;

      final formatter = NumberFormat('#,##0', 'en_US');
      String formattedNumber = formatter.format(number);

      return TextEditingValue(
        text: formattedNumber,
        selection: TextSelection.collapsed(offset: formattedNumber.length),
      );
    } catch (e) {
      return oldValue;
    }
  }
}
