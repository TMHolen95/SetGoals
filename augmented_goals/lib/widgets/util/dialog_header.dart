import 'package:augmented_goals/widgets/util/action_overflow_button.dart';

import 'package:flutter/material.dart';

class DialogHeader extends StatelessWidget {
  final String text;
  final List<TitledAction> overflowActions;

  const DialogHeader({Key key, this.text, this.overflowActions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            color: Color(0xffbceefa)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close)),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                ActionOverflowOptions(titledActions: overflowActions),
              ]),
        ));
  }
}
