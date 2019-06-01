import 'package:flutter/material.dart';

class TitledAction{
  String title;
  VoidCallback action;

  TitledAction(this.title, this.action);
}

class ActionOverflowOptions extends StatelessWidget {
  final List<TitledAction> titledActions;

  const ActionOverflowOptions({Key key, this.titledActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(titledActions?.isEmpty ?? true){
      return Container();
    }

    return PopupMenuButton<TitledAction>(
      onSelected: (titledAction) => titledAction.action(),
      itemBuilder: (BuildContext context) {
        return titledActions.map((titledAction) =>
            PopupMenuItem<TitledAction>(
              value: titledAction,
              child: Text(titledAction.title),
            )
        ).toList();
      },
    );
  }
}