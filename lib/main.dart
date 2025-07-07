import 'package:coursera__tip_calculator_app/widgets/bill_amount_field.dart';
import 'package:coursera__tip_calculator_app/widgets/person_counter.dart';
import 'package:coursera__tip_calculator_app/widgets/tip_row.dart';
import 'package:coursera__tip_calculator_app/widgets/tip_slider.dart';
import 'package:coursera__tip_calculator_app/widgets/total_per_person.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "UTip: A tip calculator app",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  // * price calculation
  final _billAmountController = TextEditingController();
  double get _billAmount => double.parse(
        _billAmountController.text.isNotEmpty
            ? _billAmountController.text
            : "0.0",
      );
  double _totalAmountPerPerson = 0.0;
  void _updateTotatAmountPerPerson() {
    setState(() {
      _totalAmountPerPerson = (_billAmount + _tipAmount) / _personCount;
    });
  }

  // * person count
  int _personCount = 1;
  void _incrementPersonCount() {
    setState(() {
      _personCount++;
    });

    _updateTipAmount();
    _updateTotatAmountPerPerson();
  }

  void _decrementPersonCount() {
    if (_personCount <= 1) return;
    setState(() {
      _personCount--;
    });

    _updateTipAmount();
    _updateTotatAmountPerPerson();
  }

  // * tip
  double _tipAmount = 0.0;
  double _tipPercentage = 0.0;
  void _updateTipPercentage(double newValue) {
    setState(() {
      _tipPercentage = newValue;
    });

    // update tip amount
    _updateTipAmount();
    _updateTotatAmountPerPerson();
  }

  void _updateTipAmount() {
    setState(() {
      _tipAmount = (_billAmount * _tipPercentage) / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UTip',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
        ),
        actions: [
          // * theme change switch button
          Switch(
            value: true,
            onChanged: (value) {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // * total tip per person
            TotalPerPerson(
              totalAmountPerPerson: _totalAmountPerPerson,
            ),

            // * bill amount container
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  // * bill amount textfield
                  BillAmountField(
                    controller: _billAmountController,
                    onChanged: (value) {
                      debugPrint('Textfield value: $value');
                      _updateTipAmount();
                      _updateTotatAmountPerPerson();
                    },
                  ),
                  SizedBox(height: 30),

                  // * split
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: textTheme.titleMedium
                            ?.copyWith(color: colorScheme.primary),
                      ),
                      PersonCounter(
                        personCount: _personCount,
                        onIncrement: _incrementPersonCount,
                        onDecrement: _decrementPersonCount,
                      )
                    ],
                  ),
                  
                  // * tip
                  TipRow(tipAmount: _tipAmount),
                  SizedBox(height: 20),

                  // * tip percentage
                  TipSlider(
                    tipPercentage: _tipPercentage,
                    onChanged: _updateTipPercentage,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
