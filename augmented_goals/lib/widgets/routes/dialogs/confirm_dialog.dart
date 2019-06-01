import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  final String title;
  final String text;
  final VoidCallback onConfirm;

  final String buttonText;
  final IconData iconData;
  final Color color;

  const ConfirmDialog(
      {Key key,
      this.text,
      this.onConfirm,
      this.title = "Confirm Dialog",
      this.buttonText = "Confirm",
      this.iconData = Icons.delete, this.color = Colors.redAccent})
      : super(key: key);

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CloseButton(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.text),
        ),
        RaisedButton(
            color: Colors.redAccent,
            child: IconTextTile(
              text: widget.buttonText,
              iconData: widget.iconData,
            ),
            onPressed: () {
              widget.onConfirm();
              Navigator.pop(context);
            }),
      ],
    ));
  }

}
