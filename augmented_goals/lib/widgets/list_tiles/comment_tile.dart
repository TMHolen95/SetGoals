  import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/data_classes/comment.dart';
import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:augmented_goals/widgets/routes/dialogs/confirm_dialog.dart';
import 'package:augmented_goals/widgets/util/account_image.dart';
import 'package:augmented_goals/widgets/util/action_overflow_button.dart';
import 'package:augmented_goals/widgets/util/report_dialog.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeParser;

class CommentTile extends StatelessWidget {
  final Comment comment;
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onDislike;

  const CommentTile({Key key, this.comment, this.onLike, this.onDislike, this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Account account = comment.account;

    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CommentPoster(
            post: post,
            account: account,
            comment: comment,
          ),
          CommentMessage(
            message: comment.message,
          ),
          Divider()
        ],
      ),
    );
  }
}

class CommentPoster extends StatelessWidget {
  final Account account;
  final Comment comment;
  final Post post;

  const CommentPoster({Key key, this.comment, this.account, this.post}) : super(key: key);

  String formattedDate(DateTime dt){
    return "";
  }

  @override
  Widget build(BuildContext context) {

    List<TitledAction> actions = [
      TitledAction("Report Comment", () => showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return ReportDialog(comment: comment,
              post: post);
        },
      ))
    ];
    if(FirestoreAPI.account.accountId == comment.account.accountId){
      actions.add(
          TitledAction("Delete Comment", () => showDialog(context: context, builder: (context) => ConfirmDialog(
              title: "Delete Comment?",
              text: "Are you sure you want to delete this comment?\nComment: ${comment.message}",
              onConfirm: () async {
                await FirestoreAPI.deleteComment(post, comment);
              })))
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AccountImage(
            account.accountPictureUrl, height: 40, width: 40,
          ),
          Column(
            children: <Widget>[
              Text(
                account.name,
                textAlign: TextAlign.start,
              ),
              Text(timeParser.format(comment.timestamp.toDate()),
                  textAlign: TextAlign.start),
            ],
          ),

          ActionOverflowOptions(
            titledActions: actions,
          )
        ],
      ),
    );
  }
}

class CommentMessage extends StatelessWidget {
  final String message;

  const CommentMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          message,
          maxLines: 100,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
