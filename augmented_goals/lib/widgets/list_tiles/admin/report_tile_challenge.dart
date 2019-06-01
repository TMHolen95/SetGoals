import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/widgets/util/accept_reject_button.dart';
import 'package:augmented_goals/widgets/util/action_overflow_button.dart';
import 'package:augmented_goals/widgets/util/category_icon.dart';
import 'package:augmented_goals/widgets/util/text.dart';
import 'package:flutter/material.dart';
class ReportTileChallenge extends StatefulWidget {

  final Challenge challenge;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ReportTileChallenge({Key key, this.challenge, this.onAccept, this.onReject}) : super(key: key);

  @override
  ReportTileChallengeState createState() {
    return new ReportTileChallengeState();
  }
}

class ReportTileChallengeState extends State<ReportTileChallenge> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border.all(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CategoryIcon(goalCategory: widget.challenge.category,),
                Expanded(child: Center(child: Headline(widget.challenge.title))),
                ActionOverflowOptions(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: Text(widget.challenge.description)),
                AcceptRejectButton(
                  onReject: widget.onReject,
                  onAccept: widget.onAccept,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
