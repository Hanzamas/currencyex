import '../models/currency.dart';
import '../repositories/currency_repository.dart';

/// Use case for getting all available currencies
class GetCurrenciesUseCase {
  final CurrencyRepository _repository;

  const GetCurrenciesUseCase(this._repository);

  /// Execute to get all available currencies
  List<Currency> execute() {
    return _repository.getAllCurrencies();
  }
}
