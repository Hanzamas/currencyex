import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currencyex/main.dart';
import 'package:currencyex/domain/models/currency.dart';
import 'package:currencyex/domain/usecases/convert_currency_usecase.dart';
import 'package:currencyex/data/datasources/static_exchange_rate_datasource.dart';
import 'package:currencyex/data/repositories/currency_repository_impl.dart';

void main() {
  group('Currency Converter Tests', () {
    late ConvertCurrencyUseCase useCase;
    late StaticExchangeRateDataSource dataSource;
    late CurrencyRepositoryImpl repository;

    setUp(() {
      dataSource = StaticExchangeRateDataSource();
      repository = CurrencyRepositoryImpl(dataSource);
      useCase = ConvertCurrencyUseCase(repository);
    });

    group('Currency Conversion Logic', () {
      test('should convert USD to IDR correctly', () {
        // Arrange
        const usd = Currency(code: 'USD', name: 'US Dollar', symbol: '\$');
        const idr = Currency(code: 'IDR', name: 'Indonesian Rupiah', symbol: 'Rp');
        const amount = 100.0;

        // Act
        final result = useCase.execute(amount: amount, from: usd, to: idr);

        // Assert
        expect(result.amount, equals(100.0));
        expect(result.fromCurrency, equals(usd));
        expect(result.toCurrency, equals(idr));
        expect(result.convertedAmount, equals(1450000.0)); // 100 * 14500
        expect(result.exchangeRate, equals(14500.0));
      });

      test('should convert EUR to USD correctly', () {
        // Arrange
        const eur = Currency(code: 'EUR', name: 'Euro', symbol: '€');
        const usd = Currency(code: 'USD', name: 'US Dollar', symbol: '\$');
        const amount = 85.0;

        // Act
        final result = useCase.execute(amount: amount, from: eur, to: usd);

        // Assert
        expect(result.amount, equals(85.0));
        expect(result.convertedAmount, closeTo(100.0, 0.01)); // 85 * (1/0.85)
      });

      test('should handle same currency conversion', () {
        // Arrange
        const usd = Currency(code: 'USD', name: 'US Dollar', symbol: '\$');
        const amount = 100.0;

        // Act
        final result = useCase.execute(amount: amount, from: usd, to: usd);

        // Assert
        expect(result.convertedAmount, equals(100.0));
        expect(result.exchangeRate, equals(1.0));
      });

      test('should throw error for negative amount', () {
        // Arrange
        const usd = Currency(code: 'USD', name: 'US Dollar', symbol: '\$');
        const idr = Currency(code: 'IDR', name: 'Indonesian Rupiah', symbol: 'Rp');

        // Act & Assert
        expect(
          () => useCase.execute(amount: -100, from: usd, to: idr),
          throwsArgumentError,
        );
      });

      test('should throw error for too large amount', () {
        // Arrange
        const usd = Currency(code: 'USD', name: 'US Dollar', symbol: '\$');
        const idr = Currency(code: 'IDR', name: 'Indonesian Rupiah', symbol: 'Rp');

        // Act & Assert
        expect(
          () => useCase.execute(amount: 1000000001, from: usd, to: idr),
          throwsArgumentError,
        );
      });
    });

    group('Data Source Tests', () {
      test('should return all currencies', () {
        // Act
        final currencies = dataSource.getAllCurrencies();

        // Assert
        expect(currencies.length, equals(10));
        expect(currencies.any((c) => c.code == 'USD'), isTrue);
        expect(currencies.any((c) => c.code == 'IDR'), isTrue);
        expect(currencies.any((c) => c.code == 'EUR'), isTrue);
      });

      test('should get correct exchange rate from USD', () {
        // Act
        final rate = dataSource.getExchangeRateFromUSD('IDR');

        // Assert
        expect(rate, equals(14500.0));
      });

      test('should throw error for unsupported currency', () {
        // Act & Assert
        expect(
          () => dataSource.getExchangeRate('USD', 'XYZ'),
          throwsArgumentError,
        );
      });
    });
  });

  group('Widget Tests', () {
    testWidgets('Currency converter app should build without errors', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the app loads
      expect(find.text('Currency Converter'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('From'), findsOneWidget);
      expect(find.text('To'), findsOneWidget);
    });

    testWidgets('Should show conversion result when amount is entered', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Enter an amount
      await tester.enterText(find.byType(TextFormField), '100');
      await tester.pump();

      // Should show some conversion result
      expect(find.text('Conversion Result'), findsOneWidget);
    });
  });
}
