import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator();
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final tipOptions = {
    "Okay (tip 10%)": 10,
    "Good (tip 15%)": 15,
    "Amazing (tip 20%)": 20,
  };

  int selectedTipPercentage = 15;
  String amount = '';
  bool roundUpTip = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Bill Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = value;
                });
              },
            ),
            const SizedBox(height: 8),
            const Text('How was the service?'),
            Column(
              children: tipOptions.entries.map((tipOption) {
                var serviceLevel = tipOption.key;
                var tipPercentage = tipOption.value;
                return RadioListTile(
                  title: Text(serviceLevel),
                  value: tipPercentage,
                  groupValue: selectedTipPercentage,
                  onChanged: (value) {
                    setState(() {
                      selectedTipPercentage = value!;
                    });
                  },
                );
              }).toList(),
            ),
            SwitchListTile(
                title: const Text('Round up tip?'),
                value: roundUpTip,
                onChanged: (value) {
                  setState(() {
                    roundUpTip = value;
                  });
                }),
            const SizedBox(height: 8),
            if (double.tryParse(amount) != null)
              Text(
                'Tip Amount: ${NumberFormat.currency(symbol: '\$').format(
                  calculateTip(
                    amount,
                    selectedTipPercentage,
                    roundUpTip,
                  ),
                )}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  double calculateTip(String amountText, int tipPercentage, bool roundUp) {
    final amount = double.tryParse(amountText) ?? 0.0;
    var tip = amount * tipPercentage / 100;

    if (roundUp) {
      tip = tip.ceilToDouble();
    }

    return tip;
  }
}
