
import 'package:flutter/material.dart';

class TipRow extends StatelessWidget {
  const TipRow({
    super.key,
    required double tipAmount,
  }) : _tipAmount = tipAmount;

  final double _tipAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Tip",
          style: textTheme.titleMedium?.copyWith(color: colorScheme.primary),
        ),
        Text(
          "₹${_tipAmount.toStringAsFixed(2)}",
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.primary),
        ),
      ],
    );
  }
}
