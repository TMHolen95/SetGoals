import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Headline extends StatelessWidget {
  final String text;
  final TextAlign alignment;
  const Headline(this.text, {Key key, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline,
      textAlign: alignment ?? TextAlign.center,
    );
  }
}


class TitleText extends StatelessWidget{
  final String text;
  final TextAlign alignment;
  const TitleText(this.text, {Key key, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
        textAlign: alignment ?? TextAlign.center,
      ),
    );
  }
}

class ListEntry extends StatelessWidget{
  final String text;
  final TextAlign alignment;
  const ListEntry(this.text, {Key key, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      " - " +text,
      maxLines: 3,
      textAlign: alignment ?? TextAlign.start,
    );
  }

}
