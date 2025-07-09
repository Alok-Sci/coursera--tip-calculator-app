import 'package:coursera__tip_calculator_app/providers/tip_calculator_provider.dart';
import 'package:coursera__tip_calculator_app/widgets/bill_amount_field.dart';
import 'package:coursera__tip_calculator_app/widgets/person_counter.dart';
import 'package:coursera__tip_calculator_app/widgets/tip_row.dart';
import 'package:coursera__tip_calculator_app/widgets/tip_slider.dart';
import 'package:coursera__tip_calculator_app/widgets/total_per_person.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: ChangeNotifierProvider(
        create: (context) => TipCalculatorProvider(),
        child: UTip(),
      ),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final provider = Provider.of<TipCalculatorProvider>(context);

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
              totalAmountPerPerson: provider.totalAmountPerPerson,
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
                    controller: provider.billAmountController,
                    onChanged: (value) {
                      debugPrint('Textfield value: $value');
                      provider.updateTipAmount();
                      provider.updateTotatAmountPerPerson();
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
                        personCount: provider.personCount,
                        onIncrement: provider.incrementPersonCount,
                        onDecrement: provider.decrementPersonCount,
                      )
                    ],
                  ),

                  // * tip
                  TipRow(
                    tipAmount: provider.tipAmount,
                    tipPercentage: provider.tipPercentage,
                    onTipPercentageUpdate: provider.updateTipPercentage,
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
