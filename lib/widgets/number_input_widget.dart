import 'package:flutter/material.dart';

class NumberInputWidget extends StatefulWidget {
  final void Function(int index, String value) onNumberChanged;

  NumberInputWidget({Key? key, required this.onNumberChanged}) : super(key: key);

  @override
  _NumberInputWidgetState createState() => _NumberInputWidgetState();
}

class _NumberInputWidgetState extends State<NumberInputWidget> {
  TextEditingController _numberController1 = TextEditingController();
  TextEditingController _numberController2 = TextEditingController();

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
          padding: EdgeInsets.only(left: 16.0),
          child: TextField(
            controller: _numberController1,
            decoration: InputDecoration(
              labelText: 'Number 1',
            ),
          )
        ),
        Container(
          padding: EdgeInsets.only(left: 16.0), // Add this line to set left margin
          child: TextField(
            controller: _numberController2,
            decoration: InputDecoration(
              labelText: 'Number 2',
            ),
          ),
        ),
      ],
    );
  }
}
