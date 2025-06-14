import '../../domain/models/currency.dart';

/// Utility class for formatting currency values
class CurrencyFormatter {
  /// Format amount with currency symbol and proper decimal places
  static String formatAmount(double amount, Currency currency) {
    // Different currencies have different decimal place conventions
    int decimalPlaces = _getDecimalPlaces(currency.code);
    
    // Format the number with appropriate decimal places
    String formattedNumber = amount.toStringAsFixed(decimalPlaces);
    
    // Add thousand separators for better readability
    formattedNumber = _addThousandSeparators(formattedNumber);
    
    return '${currency.symbol} $formattedNumber';
  }
  
  /// Format exchange rate with appropriate precision
  static String formatExchangeRate(double rate, Currency from, Currency to) {
    // Show more decimal places for very small rates
    int decimalPlaces = rate < 1 ? 6 : 4;
    return '1 ${from.code} = ${rate.toStringAsFixed(decimalPlaces)} ${to.code}';
  }
  
  /// Get appropriate decimal places for different currencies
  static int _getDecimalPlaces(String currencyCode) {
    switch (currencyCode) {
      case 'JPY':  // Japanese Yen - no decimal places
      case 'KRW':  // Korean Won - no decimal places
      case 'IDR':  // Indonesian Rupiah - usually no decimal places
        return 0;
      default:
        return 2;
    }
  }
  
  /// Add thousand separators to number string
  static String _addThousandSeparators(String numberString) {
    List<String> parts = numberString.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';
    
    // Add commas to integer part
    String formattedInteger = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedInteger += ',';
      }
      formattedInteger += integerPart[i];
    }
    
    return decimalPart.isNotEmpty 
        ? '$formattedInteger.$decimalPart'
        : formattedInteger;
  }
}
