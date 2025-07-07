import 'package:flutter/material.dart';

class PersonCounter extends StatelessWidget {
  const PersonCounter({
    super.key,
    required this.colorScheme,
    required int personCount,
    required this.onIncrement,
    required this.onDecrement,
  }) : _personCount = personCount;

  final ColorScheme colorScheme;
  final int _personCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
          icon: Icon(
            Icons.remove_rounded,
            color: colorScheme.primary,
          ),
          onPressed: onDecrement,
        ),
        Text(
          _personCount.toString(),
          style: TextStyle(
            color: colorScheme.primary,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add_rounded,
            color: colorScheme.primary,
          ),
          onPressed: onIncrement,
        ),
      ],
    );
  }
}
