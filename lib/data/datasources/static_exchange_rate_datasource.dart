import '../../domain/models/currency.dart';

/// Static data source for exchange rates
class StaticExchangeRateDataSource {
  /// Base currency for all exchange rates (USD)
  static const Currency baseCurrency = Currency(
    code: 'USD',
    name: 'US Dollar',
    symbol: '\$',
  );

  /// Exchange rates relative to USD
  static const Map<String, double> _exchangeRates = {
    'USD': 1.0,      // US Dollar
    'EUR': 0.85,     // Euro
    'GBP': 0.73,     // British Pound
    'JPY': 110.0,    // Japanese Yen
    'IDR': 14500.0,  // Indonesian Rupiah
    'SGD': 1.35,     // Singapore Dollar
    'MYR': 4.15,     // Malaysian Ringgit
    'THB': 33.0,     // Thai Baht
    'CNY': 6.45,     // Chinese Yuan
    'KRW': 1180.0,   // South Korean Won
  };

  /// Get exchange rate from USD to target currency
  double getExchangeRateFromUSD(String currencyCode) {
    return _exchangeRates[currencyCode] ?? 1.0;
  }
  /// Get exchange rate between two currencies
  double getExchangeRate(String fromCode, String toCode) {
    if (fromCode == toCode) return 1.0;
    
    // Validate currency codes
    if (!_exchangeRates.containsKey(fromCode)) {
      throw ArgumentError('Currency code "$fromCode" is not supported');
    }
    
    if (!_exchangeRates.containsKey(toCode)) {
      throw ArgumentError('Currency code "$toCode" is not supported');
    }
    
    final fromRate = _exchangeRates[fromCode]!;
    final toRate = _exchangeRates[toCode]!;
    
    // Convert from -> USD -> to
    return toRate / fromRate;
  }

  /// Get all available currencies
  List<Currency> getAllCurrencies() {
    return _currencies;
  }

  static const List<Currency> _currencies = [
    Currency(code: 'USD', name: 'US Dollar', symbol: '\$'),
    Currency(code: 'EUR', name: 'Euro', symbol: '€'),
    Currency(code: 'GBP', name: 'British Pound', symbol: '£'),
    Currency(code: 'JPY', name: 'Japanese Yen', symbol: '¥'),
    Currency(code: 'IDR', name: 'Indonesian Rupiah', symbol: 'Rp'),
    Currency(code: 'SGD', name: 'Singapore Dollar', symbol: 'S\$'),
    Currency(code: 'MYR', name: 'Malaysian Ringgit', symbol: 'RM'),
    Currency(code: 'THB', name: 'Thai Baht', symbol: '฿'),
    Currency(code: 'CNY', name: 'Chinese Yuan', symbol: '¥'),
    Currency(code: 'KRW', name: 'South Korean Won', symbol: '₩'),
  ];
}
