import 'package:flutter/material.dart';

enum TogglePurpose { ErrorValidation, ShowEnabledIcon }

class ToggleIcon extends StatefulWidget {
  final bool state;
  final IconData isTrue;
  final IconData isFalse;
  final TogglePurpose purpose;

  const ToggleIcon(
      {Key key, this.state, this.isTrue, this.isFalse, this.purpose})
      : super(key: key);

  @override
  ToggleIconState createState() {
    return new ToggleIconState();
  }
}

class ToggleIconState extends State<ToggleIcon> {
  Color isTrueColor;
  Color isFalseColor;

  @override
  Widget build(BuildContext context) {
    switch (widget.purpose) {
      case TogglePurpose.ErrorValidation:
        isTrueColor = Colors.lightGreen;
        isFalseColor = Colors.red;
        break;
      case TogglePurpose.ShowEnabledIcon:
        isTrueColor = Colors.blue;
        isFalseColor = Colors.grey;
        break;
    }

    return widget.state
        ? Icon(widget.isTrue, color: isTrueColor ?? Colors.lightGreen)
        : Icon(
            widget.isFalse,
            color: isFalseColor ?? Colors.red,
          );
  }
}
