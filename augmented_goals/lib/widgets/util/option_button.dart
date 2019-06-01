import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool selected;

  const OptionButton({Key key, this.onPressed, this.text, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: selected
            ? Colors.lightBlueAccent
            : Color(0xffe0e0e0),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(text)),
      ),
    );
  }
}

