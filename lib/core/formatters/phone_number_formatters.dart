import 'dart:math';

import 'package:flutter/services.dart';

class UzbNumberTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // remove any non-digit characters
    var digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // max to 9 digits
    if (digitsOnly.length > 9) {
      digitsOnly = digitsOnly.substring(0, 9);
    }

    final newString = StringBuffer();
    var selectionIndex = newValue.selection.end;
    var offset = 0;

    // adds digits with spaces according to pattern (00 000 0000)
    for (var i = 0; i < digitsOnly.length; i++) {
      if (i == 2 || i == 5) {
        // adds spaces after 2nd and 5th digits
        newString.write(' ');
        if (selectionIndex > i) {
          offset++;
        }
      }
      newString.write(digitsOnly[i]);
    }

    return TextEditingValue(
      text: newString.toString(),
      selection: TextSelection.collapsed(
        offset: min(selectionIndex + offset, newString.length),
      ),
    );
  }
}
