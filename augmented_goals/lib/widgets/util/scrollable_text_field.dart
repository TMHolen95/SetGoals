import 'package:flutter/material.dart';

class ScrollableTextField extends StatelessWidget {
  final String text;

  const ScrollableTextField({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(text),
        ),
      ),
    );
  }
}