import 'package:flutter/material.dart';

class OperationWidget extends StatefulWidget {
  final Function(String) onOperationSelected;

  OperationWidget({Key? key, required this.onOperationSelected})
      : super(key: key);

  @override
  _OperationWidgetState createState() => _OperationWidgetState();
}

class _OperationWidgetState extends State<OperationWidget> {
  String _selectedOperation = "+";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedOperation,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedOperation = newValue;
              });
              widget.onOperationSelected(newValue);
            }
          },
          items: ["+", "-", "*", "/"].map<DropdownMenuItem<String>>(
            (String operation) {
              return DropdownMenuItem<String>(
                value: operation,
                child: Text(operation),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
