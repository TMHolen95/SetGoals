import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HelpWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onCloseHelp;
  const HelpWidget({Key key, this.onCloseHelp, this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                  child: Text(title,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline)),
              IconButton(icon: Icon(Icons.cancel), onPressed: onCloseHelp)
            ]),
            ListTile(title: child)
          ],
        ),
      ),
    );
  }
}