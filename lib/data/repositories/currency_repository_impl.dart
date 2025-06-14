import '../../domain/models/currency.dart';
import '../../domain/models/conversion_result.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/static_exchange_rate_datasource.dart';

/// Implementation of CurrencyRepository using static data
class CurrencyRepositoryImpl implements CurrencyRepository {
  final StaticExchangeRateDataSource _dataSource;

  const CurrencyRepositoryImpl(this._dataSource);

  @override
  List<Currency> getAllCurrencies() {
    return _dataSource.getAllCurrencies();
  }

  @override
  double getExchangeRate(Currency from, Currency to) {
    return _dataSource.getExchangeRate(from.code, to.code);
  }

  @override
  ConversionResult convertCurrency({
    required double amount,
    required Currency from,
    required Currency to,
  }) {
    final exchangeRate = getExchangeRate(from, to);
    final convertedAmount = amount * exchangeRate;

    return ConversionResult(
      amount: amount,
      fromCurrency: from,
      toCurrency: to,
      convertedAmount: convertedAmount,
      exchangeRate: exchangeRate,
    );
  }
}
