import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';

import 'number_converter.dart';
import 'calculator.dart';
import 'widgets/number_input_widget.dart';
import 'widgets/operation_widget.dart';
import 'widgets/result_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fraction and Recurring Decimal Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Fraction and Recurring Decimal Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String _number1 = '';
  String _number2 = '';
  String _selectedOperation = "*";
  String _resultFraction = '0';
  String _resultRecurringDecimal = '0';

  void _calculateResult() {
    Fraction result = Calculator.calculate(
      _number1,
      _number2,
      _selectedOperation,
    );
    setState(() {
      _resultFraction = result.toString();
      _resultRecurringDecimal = NumberConverter.toRecurringDecimal(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            NumberInputWidget(
              onNumberChanged: (index, number) {
                setState(() {
                  if (index == 1) {
                    _number1 = number;
                  } else if (index == 2) {
                    _number2 = number;
                  }
                });
              },
            ),
            OperationWidget(
              onOperationSelected: (operation) {
                setState(() {
                  _selectedOperation = operation;
                });
              },
            ),
            ElevatedButton(
              onPressed: _calculateResult,
              child: const Text('Calculate'),
            ),
            ResultWidget(
              resultFraction: _resultFraction,
              resultRecurringDecimal: _resultRecurringDecimal,
            ),
          ],
        ),
      ),
    );
  }
}
