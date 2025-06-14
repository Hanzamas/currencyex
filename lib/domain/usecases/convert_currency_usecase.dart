import '../models/currency.dart';
import '../models/conversion_result.dart';
import '../repositories/currency_repository.dart';

/// Use case for converting currency amounts
class ConvertCurrencyUseCase {
  final CurrencyRepository _repository;

  const ConvertCurrencyUseCase(this._repository);

  /// Execute currency conversion with validation
  ConversionResult execute({
    required double amount,
    required Currency from,
    required Currency to,
  }) {
    // Input validation
    if (amount < 0) {
      throw ArgumentError('Amount cannot be negative');
    }
    
    if (amount > 1000000000) {
      throw ArgumentError('Amount is too large');
    }

    if (from.code.isEmpty || to.code.isEmpty) {
      throw ArgumentError('Invalid currency codes');
    }

    return _repository.convertCurrency(
      amount: amount,
      from: from,
      to: to,
    );
  }
}
