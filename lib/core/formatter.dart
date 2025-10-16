import 'package:intl/intl.dart';

String formatMoney(double amount) {
  // Use NumberFormat for thousands separator and fixed decimal style
  final formatter = NumberFormat('#,##0.###', 'en_US');

  // For numbers less than 100, show normally (no forced commas)
  // if (amount < 100) {
  //   // keep up to 2 decimal places, but remove trailing zero
  //   return amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 1);
  // }

  // For 100 and above, add commas and keep one decimal if needed
  String formatted = formatter.format(amount);

  // Ensure one decimal place if it exists
  if (formatted.contains('.')) {
    // keep only one decimal digit
    final parts = formatted.split('.');
    formatted = '${parts[0]}.${parts[1][0]}';
  }
  return formatted;
}
