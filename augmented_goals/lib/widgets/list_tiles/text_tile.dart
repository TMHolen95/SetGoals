import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextTile extends StatelessWidget {
  final String message;

  const TextTile(
      {Key key, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(child: Text(message,textAlign: TextAlign.center,)),
    );
  }
}