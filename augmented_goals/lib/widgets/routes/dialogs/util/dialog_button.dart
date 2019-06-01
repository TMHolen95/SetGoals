import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final VoidCallback onPressed;

  const DialogButton({Key key, this.text, this.bgColor, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          color: bgColor ?? Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: Theme.of(context).textTheme.button,),
          ),
        ),
      ),
    );
  }
}
