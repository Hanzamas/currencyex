import 'package:flutter/material.dart';
import 'core/di/dependency_injection.dart';
import 'presentation/pages/currency_converter_page.dart';

void main() {
  // Initialize dependency injection
  DependencyInjection().initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: CurrencyConverterPage(
        notifier: DependencyInjection().currencyConverterNotifier,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
