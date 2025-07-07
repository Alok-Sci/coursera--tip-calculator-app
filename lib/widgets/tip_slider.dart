
import 'package:flutter/material.dart';

class TipSlider extends StatelessWidget {
  const TipSlider({
    super.key,
    required double tipPercentage,
    required this.onChanged,
  }) : _tipPercentage = tipPercentage;

  final double _tipPercentage;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            "${_tipPercentage.toStringAsFixed(2)}%",
            style: textTheme.labelLarge?.copyWith(color: colorScheme.primary),
          ),
        ),
        Slider(
          value: _tipPercentage,
          min: 0.0,
          max: 100.0,
          divisions: 20,
          label: _tipPercentage.toStringAsFixed(2),
          onChanged: onChanged,
        )
      ],
    );
  }
}
