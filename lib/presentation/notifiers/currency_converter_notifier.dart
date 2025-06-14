import 'package:flutter/foundation.dart';
import '../../domain/models/currency.dart';
import '../../domain/models/conversion_result.dart';
import '../../domain/usecases/convert_currency_usecase.dart';
import '../../domain/usecases/get_currencies_usecase.dart';

/// State management for currency conversion
class CurrencyConverterNotifier extends ChangeNotifier {
  final ConvertCurrencyUseCase _convertCurrencyUseCase;
  final GetCurrenciesUseCase _getCurrenciesUseCase;

  CurrencyConverterNotifier(
    this._convertCurrencyUseCase,
    this._getCurrenciesUseCase,
  ) {
    _loadCurrencies();
  }

  // State variables
  List<Currency> _currencies = [];
  Currency? _fromCurrency;
  Currency? _toCurrency;
  double _amount = 0.0;
  ConversionResult? _conversionResult;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Currency> get currencies => _currencies;
  Currency? get fromCurrency => _fromCurrency;
  Currency? get toCurrency => _toCurrency;
  double get amount => _amount;
  ConversionResult? get conversionResult => _conversionResult;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get canConvert => 
      _fromCurrency != null && 
      _toCurrency != null && 
      _amount > 0;

  void _loadCurrencies() {
    try {
      _currencies = _getCurrenciesUseCase.execute();
      // Set default currencies
      if (_currencies.isNotEmpty) {
        _fromCurrency = _currencies.firstWhere(
          (currency) => currency.code == 'USD',
          orElse: () => _currencies.first,
        );
        _toCurrency = _currencies.firstWhere(
          (currency) => currency.code == 'IDR',
          orElse: () => _currencies.length > 1 
              ? _currencies[1] 
              : _currencies.first,
        );
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load currencies: $e';
      notifyListeners();
    }
  }

  void setFromCurrency(Currency currency) {
    _fromCurrency = currency;
    _clearError();
    if (canConvert) {
      _performConversion();
    }
    notifyListeners();
  }

  void setToCurrency(Currency currency) {
    _toCurrency = currency;
    _clearError();
    if (canConvert) {
      _performConversion();
    }
    notifyListeners();
  }

  void setAmount(double amount) {
    _amount = amount;
    _clearError();
    if (canConvert) {
      _performConversion();
    }
    notifyListeners();
  }

  void swapCurrencies() {
    if (_fromCurrency != null && _toCurrency != null) {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _clearError();
      if (canConvert) {
        _performConversion();
      }
      notifyListeners();
    }
  }

  void _performConversion() {
    if (!canConvert) return;

    try {
      _isLoading = true;
      notifyListeners();

      _conversionResult = _convertCurrencyUseCase.execute(
        amount: _amount,
        from: _fromCurrency!,
        to: _toCurrency!,
      );
    } catch (e) {
      _errorMessage = 'Conversion failed: $e';
      _conversionResult = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _clearError() {
    _errorMessage = null;
  }

  void clearAll() {
    _amount = 0.0;
    _conversionResult = null;
    _errorMessage = null;
    notifyListeners();
  }
}
