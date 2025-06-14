import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom input field for amount entry
class AmountInputField extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final String label;
  final String? currencySymbol;
  final bool enabled;

  const AmountInputField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.currencySymbol,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: value > 0 ? value.toString() : '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            hintText: 'Enter amount',
            prefixText: currencySymbol != null ? '$currencySymbol ' : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onChanged: (value) {
            final amount = double.tryParse(value) ?? 0.0;
            onChanged(amount);
          },
        ),
      ],
    );
  }
}
