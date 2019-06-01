import 'package:augmented_goals/widgets/util/vertical_divider.dart';
import 'package:flutter/material.dart';

class AcceptRejectButton extends StatefulWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const AcceptRejectButton({Key key, this.onAccept, this.onReject})
      : super(key: key);

  @override
  AcceptRejectButtonState createState() {
    return new AcceptRejectButtonState();
  }
}

class AcceptRejectButtonState extends State<AcceptRejectButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.block,
                  color: Colors.redAccent,
                ),
                onPressed: widget.onReject,
              ),
              VerticalLine(),
              IconButton(
                icon: Icon(Icons.check, color: Colors.green),
                onPressed: widget.onAccept,
              )
            ],
          ),
        ]);
  }
}
