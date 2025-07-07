import 'package:flutter/material.dart';

class BillAmountField extends StatelessWidget {
  const BillAmountField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.currency_rupee_rounded,
          color: colorScheme.primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primaryFixedDim,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
          ),
        ),
        label: Text("Bill Amount"),
        hintText: "eg. 10.8",
        hintStyle:
            textTheme.bodyMedium?.copyWith(color: colorScheme.primaryFixedDim),
      ),
      onChanged: onChanged,
    );
  }
}
