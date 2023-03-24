import 'package:flutter/material.dart';

class NumberInputWidget extends StatefulWidget {
  final void Function(int index, String value) onNumberChanged;

  const NumberInputWidget({Key? key, required this.onNumberChanged}) : super(key: key);

  @override
  NumberInputWidgetState createState() => NumberInputWidgetState();
}

class NumberInputWidgetState extends State<NumberInputWidget> {
  final TextEditingController _numberController1 = TextEditingController();
  final TextEditingController _numberController2 = TextEditingController();

  @override
  void initState() {
    super.initState();

    _numberController1.addListener(() {
      widget.onNumberChanged(1, _numberController1.text);
    });

    _numberController2.addListener(() {
      widget.onNumberChanged(2, _numberController2.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            controller: _numberController1,
            decoration: const InputDecoration(
              labelText: 'Number 1',
            ),
          )
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0), // Add this line to set left margin
          child: TextField(
            controller: _numberController2,
            decoration: const InputDecoration(
              labelText: 'Number 2',
            ),
          ),
        ),
      ],
    );
  }
}
