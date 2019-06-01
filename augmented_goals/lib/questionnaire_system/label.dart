import 'package:flutter/material.dart';

/// Basically a [Text] styled appropriately for the [LikertScale] widget.
/// Note space " " is automatically replaced with "\n".
class Label extends StatelessWidget {
  @required
  final String string;

  const Label(this.string, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String newString = string.replaceAll(RegExp("[ ]"), "\n");
    return Align(alignment: Alignment.center, child: Text(newString, style: Theme.of(context).textTheme.caption, textAlign: TextAlign.center, maxLines: 2,));
  }
}