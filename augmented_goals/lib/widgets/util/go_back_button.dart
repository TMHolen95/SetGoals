import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GoBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}