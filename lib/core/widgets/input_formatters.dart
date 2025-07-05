import 'package:flutter/services.dart';

class ReverseSpaceEveryThreeDigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    String reversed = digitsOnly.split('').reversed.join();
    List<String> chunks = [];

    for (int i = 0; i < reversed.length; i += 3) {
      int end = (i + 3 < reversed.length) ? i + 3 : reversed.length;
      chunks.add(reversed.substring(i, end));
    }

    String spaced = chunks
        .map((e) => e.split('').reversed.join())
        .toList()
        .reversed
        .join(' ');

    return TextEditingValue(
      text: spaced,
      selection: TextSelection.collapsed(offset: spaced.length),
    );
  }
}
