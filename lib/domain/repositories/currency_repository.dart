import '../models/currency.dart';
import '../models/conversion_result.dart';

/// Abstract repository interface for currency exchange operations
abstract class CurrencyRepository {
  /// Get all available currencies
  List<Currency> getAllCurrencies();
  
  /// Get exchange rate from one currency to another
  double getExchangeRate(Currency from, Currency to);
  
  /// Convert amount from one currency to another
  ConversionResult convertCurrency({
    required double amount,
    required Currency from,
    required Currency to,
  });
}
