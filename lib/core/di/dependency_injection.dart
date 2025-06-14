import '../../data/datasources/static_exchange_rate_datasource.dart';
import '../../data/repositories/currency_repository_impl.dart';
import '../../domain/usecases/convert_currency_usecase.dart';
import '../../domain/usecases/get_currencies_usecase.dart';
import '../../presentation/notifiers/currency_converter_notifier.dart';

/// Dependency injection container
class DependencyInjection {
  // Singleton instance
  static final DependencyInjection _instance = DependencyInjection._internal();
  factory DependencyInjection() => _instance;
  DependencyInjection._internal();

  // Data source
  late final StaticExchangeRateDataSource _dataSource;
  
  // Repository
  late final CurrencyRepositoryImpl _repository;
  
  // Use cases
  late final ConvertCurrencyUseCase _convertCurrencyUseCase;
  late final GetCurrenciesUseCase _getCurrenciesUseCase;
  
  // Notifier
  late final CurrencyConverterNotifier _currencyConverterNotifier;

  /// Initialize all dependencies
  void initialize() {
    // Data source
    _dataSource = StaticExchangeRateDataSource();
    
    // Repository
    _repository = CurrencyRepositoryImpl(_dataSource);
    
    // Use cases
    _convertCurrencyUseCase = ConvertCurrencyUseCase(_repository);
    _getCurrenciesUseCase = GetCurrenciesUseCase(_repository);
    
    // Notifier
    _currencyConverterNotifier = CurrencyConverterNotifier(
      _convertCurrencyUseCase,
      _getCurrenciesUseCase,
    );
  }

  // Getters for dependencies
  StaticExchangeRateDataSource get dataSource => _dataSource;
  CurrencyRepositoryImpl get repository => _repository;
  ConvertCurrencyUseCase get convertCurrencyUseCase => _convertCurrencyUseCase;
  GetCurrenciesUseCase get getCurrenciesUseCase => _getCurrenciesUseCase;
  CurrencyConverterNotifier get currencyConverterNotifier => _currencyConverterNotifier;
}
