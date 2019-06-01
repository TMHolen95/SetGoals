import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectableTextTile extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  final bool selected;
  const SelectableTextTile(
      {Key key, this.message, this.onTap, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        selected: selected,
        title: Center(child: Text(message,textAlign: TextAlign.center,)),
      ),
    );
  }
}