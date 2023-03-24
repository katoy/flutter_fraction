import 'package:flutter/material.dart';

class ResultWidget extends StatefulWidget {
  final String resultFraction;
  final String resultRecurringDecimal;

  const ResultWidget({Key? key, required this.resultFraction, required this.resultRecurringDecimal})
      : super(key: key);

  @override
  ResultWidgetState createState() => ResultWidgetState();
}

class ResultWidgetState extends State<ResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Fraction: ${widget.resultFraction}'),
        Text('Recurring Decimal: ${widget.resultRecurringDecimal}'),
      ],
    );
  }
}
