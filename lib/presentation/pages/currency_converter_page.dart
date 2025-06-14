import 'package:flutter/material.dart';
import '../notifiers/currency_converter_notifier.dart';
import '../widgets/currency_dropdown.dart';
import '../widgets/amount_input_field.dart';
import '../widgets/conversion_result_card.dart';

/// Main currency converter page
class CurrencyConverterPage extends StatelessWidget {
  final CurrencyConverterNotifier notifier;

  const CurrencyConverterPage({
    super.key,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: notifier.clearAll,
            tooltip: 'Clear all',
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: notifier,
        builder: (context, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Amount input
                AmountInputField(
                  value: notifier.amount,
                  onChanged: notifier.setAmount,
                  label: 'Amount',
                  currencySymbol: notifier.fromCurrency?.symbol,
                ),
                
                const SizedBox(height: 24),
                
                // Currency selection row
                Row(
                  children: [
                    // From currency
                    Expanded(
                      child: CurrencyDropdown(
                        currencies: notifier.currencies,
                        selectedCurrency: notifier.fromCurrency,
                        onChanged: (currency) {
                          if (currency != null) {
                            notifier.setFromCurrency(currency);
                          }
                        },
                        label: 'From',
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Swap button
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: IconButton(
                        onPressed: notifier.swapCurrencies,
                        icon: const Icon(Icons.swap_horiz),
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        tooltip: 'Swap currencies',
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // To currency
                    Expanded(
                      child: CurrencyDropdown(
                        currencies: notifier.currencies,
                        selectedCurrency: notifier.toCurrency,
                        onChanged: (currency) {
                          if (currency != null) {
                            notifier.setToCurrency(currency);
                          }
                        },
                        label: 'To',
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Error message
                if (notifier.errorMessage != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            notifier.errorMessage!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Conversion result
                ConversionResultCard(
                  result: notifier.conversionResult,
                  isLoading: notifier.isLoading,
                ),
                
                const SizedBox(height: 24),
                
                // Info text
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Exchange Rate Information',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Exchange rates are static and for demonstration purposes only. '
                        'In a real application, you would fetch live rates from a financial API.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
