import 'package:coursera__tip_calculator_app/widgets/tip_slider.dart';
import 'package:flutter/material.dart';

class TipRow extends StatelessWidget {
  const TipRow({
    super.key,
    required double tipAmount,
    required double tipPercentage,
    required this.onTipPercentageUpdate,
  })  : _tipAmount = tipAmount,
        _tipPercentage = tipPercentage;

  final double _tipAmount;
  final double _tipPercentage;
  final ValueChanged<double> onTipPercentageUpdate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tip",
              style:
                  textTheme.titleMedium?.copyWith(color: colorScheme.primary),
            ),
            Text(
              "₹${_tipAmount.toStringAsFixed(2)}",
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.primary),
            ),
          ],
        ),
        SizedBox(height: 20),

        // * tip percentage
        TipSlider(
          tipPercentage: _tipPercentage,
          onChanged: onTipPercentageUpdate,
        ),
      ],
    );
  }
}
