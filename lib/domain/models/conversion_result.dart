import 'currency.dart';

/// Represents the result of a currency conversion
class ConversionResult {
  final double amount;
  final Currency fromCurrency;
  final Currency toCurrency;
  final double convertedAmount;
  final double exchangeRate;

  const ConversionResult({
    required this.amount,
    required this.fromCurrency,
    required this.toCurrency,
    required this.convertedAmount,
    required this.exchangeRate,
  });

  @override
  String toString() {
    return '${amount.toStringAsFixed(2)} ${fromCurrency.symbol} = '
           '${convertedAmount.toStringAsFixed(2)} ${toCurrency.symbol}';
  }
}
