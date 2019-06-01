import 'package:augmented_goals/data_classes/comment.dart';
import 'package:augmented_goals/widgets/util/accept_reject_button.dart';
import 'package:augmented_goals/widgets/util/account_image.dart';
import 'package:augmented_goals/widgets/util/text.dart';
import 'package:flutter/material.dart';
class ReportTileComment extends StatefulWidget {

  final Comment comment;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ReportTileComment({Key key, this.comment, this.onAccept, this.onReject}) : super(key: key);

  @override
  ReportTileCommentState createState() {
    return new ReportTileCommentState();
  }
}

class ReportTileCommentState extends State<ReportTileComment> {

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
                AccountImage(widget.comment.account.accountPictureUrl),
                Headline(widget.comment.account.name),              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: Text(widget.comment.message)),
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