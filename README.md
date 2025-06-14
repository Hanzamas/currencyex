# Currency Converter App

A clean, modular Flutter application for converting between different currencies using static exchange rates. Built following clean architecture principles.

## Features

- 🔄 Convert between 10 major currencies
- 💱 Real-time conversion as you type
- 🔀 Swap currencies with one tap
- 📱 Beautiful, responsive Material Design 3 UI
- 🌙 Dark and light theme support
- 🏗️ Clean architecture with separation of concerns

## Supported Currencies

- **USD** - US Dollar ($)
- **EUR** - Euro (€)
- **GBP** - British Pound (£)
- **JPY** - Japanese Yen (¥)
- **IDR** - Indonesian Rupiah (Rp)
- **SGD** - Singapore Dollar (S$)
- **MYR** - Malaysian Ringgit (RM)
- **THB** - Thai Baht (฿)
- **CNY** - Chinese Yuan (¥)
- **KRW** - South Korean Won (₩)

## Architecture

This project follows **Clean Architecture** principles with clear separation of layers:

### 📁 Project Structure

```
lib/
├── core/
│   └── di/
│       └── dependency_injection.dart     # Dependency injection container
├── data/
│   ├── datasources/
│   │   └── static_exchange_rate_datasource.dart  # Static exchange rates
│   └── repositories/
│       └── currency_repository_impl.dart # Repository implementation
├── domain/
│   ├── models/
│   │   ├── currency.dart                 # Currency model
│   │   └── conversion_result.dart        # Conversion result model
│   ├── repositories/
│   │   └── currency_repository.dart      # Repository interface
│   └── usecases/
│       ├── convert_currency_usecase.dart # Currency conversion logic
│       └── get_currencies_usecase.dart   # Get available currencies
└── presentation/
    ├── notifiers/
    │   └── currency_converter_notifier.dart  # State management
    ├── pages/
    │   └── currency_converter_page.dart      # Main UI page
    └── widgets/
        ├── amount_input_field.dart           # Amount input widget
        ├── conversion_result_card.dart       # Result display widget
        └── currency_dropdown.dart            # Currency selection widget
```

### 🏗️ Clean Architecture Layers

1. **Domain Layer** (`domain/`)
   - Contains business logic and entities
   - Independent of frameworks and external concerns
   - Defines repository interfaces and use cases

2. **Data Layer** (`data/`)
   - Implements repository interfaces
   - Handles data sources (static exchange rates)
   - Manages data transformation

3. **Presentation Layer** (`presentation/`)
   - UI components and state management
   - Depends on domain layer through dependency injection
   - Handles user interactions and displays data

4. **Core Layer** (`core/`)
   - Dependency injection setup
   - Shared utilities and configurations

## Getting Started

### Prerequisites

- Flutter SDK (>=3.7.0)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd currencyex
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Usage

1. **Enter Amount**: Type the amount you want to convert in the amount field
2. **Select Currencies**: Choose source and target currencies from the dropdowns
3. **View Result**: The conversion result appears automatically
4. **Swap Currencies**: Tap the swap icon to quickly switch source and target currencies
5. **Clear**: Use the refresh button to clear all inputs

## Key Design Principles

### 🎯 **SOLID Principles**

- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Repository implementations are substitutable
- **Interface Segregation**: Small, focused interfaces
- **Dependency Inversion**: High-level modules don't depend on low-level modules

### 🧩 **Clean Architecture Benefits**

- **Testability**: Easy to unit test business logic
- **Maintainability**: Clear separation of concerns
- **Scalability**: Easy to add new features or data sources
- **Independence**: UI and business logic are decoupled

### 📦 **Modular Design**

- **Reusable Widgets**: Custom widgets for currency dropdown, amount input, and result display
- **Use Cases**: Business logic encapsulated in specific use cases
- **Repository Pattern**: Data access abstracted through interfaces
- **Dependency Injection**: Centralized dependency management

## Customization

### Adding New Currencies

1. Update `StaticExchangeRateDataSource`:
   ```dart
   static const Map<String, double> _exchangeRates = {
     // Add new currency with exchange rate to USD
     'NEW': exchangeRateToUSD,
   };
   
   static const List<Currency> _currencies = [
     // Add new currency object
     Currency(code: 'NEW', name: 'New Currency', symbol: 'N$'),
   ];
   ```

### Integrating Live Exchange Rates

To use live exchange rates instead of static ones:

1. Create a new data source implementing real API calls
2. Update the repository implementation
3. Add network dependencies to `pubspec.yaml`
4. Handle loading states and error cases

## Testing

The clean architecture makes testing straightforward:

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

Each layer can be tested independently:
- **Domain**: Test use cases and models
- **Data**: Test repository implementations and data sources
- **Presentation**: Test UI components and state management

## Contributing

1. Fork the project
2. Create a feature branch
3. Follow the existing architecture patterns
4. Add tests for new functionality
5. Submit a pull request

## License

This project is for educational purposes and demonstrates clean architecture principles in Flutter development.

---

**Note**: Exchange rates in this application are static and for demonstration purposes only. For production use, integrate with a real-time financial data API.