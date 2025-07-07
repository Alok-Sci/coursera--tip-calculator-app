import 'package:coursera__tip_calculator_app/widgets/person_counter.dart';
import 'package:coursera__tip_calculator_app/widgets/tip_slider.dart';
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
  double _billAmount = 0.0;
  double _totalAmountPerPerson = 0.0;

  // * person count
  int _personCount = 1;
  void _incrementPersonCount() {
    setState(() {
      _personCount++;
    });
  }

  void _decrementPersonCount() {
    if (_personCount <= 1) return;
    setState(() {
      _personCount--;
    });
  }

  // * tip
  double _tipAmount = 0.0;
  double _tipPercentage = 0.0;
  void _updateTipPercentage(double newValue) {
    _tipPercentage = newValue;
    // update tip amount
    _updateTipAmount();

    setState(() {});
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
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total Per Person",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: colorScheme.onPrimary),
                  ),
                  Text(
                    "₹${_totalAmountPerPerson.toStringAsFixed(2)}",
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
                  TextField(
                    keyboardType: TextInputType.number,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: colorScheme.primary),
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
                      hintStyle: textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.primaryFixedDim),
                    ),
                    onChanged: (value) {
                      debugPrint('Textfield value: $value');
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: textTheme.titleMedium
                            ?.copyWith(color: colorScheme.primary),
                      ),
                      Text(
                        "₹${_tipAmount.toStringAsFixed(2)}",
                        style: textTheme.bodyLarge
                            ?.copyWith(color: colorScheme.primary),
                      ),
                    ],
                  ),
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
