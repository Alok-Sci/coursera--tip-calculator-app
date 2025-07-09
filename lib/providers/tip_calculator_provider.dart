import 'package:flutter/material.dart';

class TipCalculatorProvider extends ChangeNotifier {
  // * price calculation
  final billAmountController = TextEditingController();
  double get billAmount => double.parse(
        billAmountController.text.isNotEmpty
            ? billAmountController.text
            : "0.0",
      );
  double _totalAmountPerPerson = 0.0;
  double get totalAmountPerPerson => _totalAmountPerPerson;
  void updateTotatAmountPerPerson() {
    _totalAmountPerPerson = (billAmount + _tipAmount) / _personCount;
    notifyListeners();
  }

  // * person count
  int _personCount = 1;
  int get personCount => _personCount;
  void incrementPersonCount() {
    _personCount++;

    updateTipAmount();
    updateTotatAmountPerPerson();

    notifyListeners();
  }

  void decrementPersonCount() {
    if (_personCount <= 1) return;
    _personCount--;

    updateTipAmount();
    updateTotatAmountPerPerson();

    notifyListeners();
  }

  // * tip
  double _tipAmount = 0.0;
  double get tipAmount => _tipAmount;

  double _tipPercentage = 0.0;
  double get tipPercentage => _tipPercentage;

  void updateTipPercentage(double newValue) {
    _tipPercentage = newValue;

    // update tip amount
    updateTipAmount();
    updateTotatAmountPerPerson();

    notifyListeners();
  }

  void updateTipAmount() {
    _tipAmount = (billAmount * _tipPercentage) / 100;
    notifyListeners();
  }
}
