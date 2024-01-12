import 'package:intl/intl.dart';

class HumanFormats{
  static String number (double number){
    final formattedNumber=NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en-US'
    ).format(number);
    return formattedNumber;
  }
}