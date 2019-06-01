import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/widgets/list_tiles/post_tile.dart';
import 'package:augmented_goals/widgets/util/accept_reject_button.dart';
import 'package:flutter/material.dart';
class ReportTilePost extends StatefulWidget {

  final Post post;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ReportTilePost({Key key, this.post, this.onAccept, this.onReject}) : super(key: key);

  @override
  ReportTilePostState createState() {
    return new ReportTilePostState();
  }
}

class ReportTilePostState extends State<ReportTilePost> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border.all(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            PostTile(
              post: widget.post,
              truncate: true,
              showCommentSection: false,
            ),
            AcceptRejectButton(
              onReject: widget.onReject,
              onAccept: widget.onAccept,
            )
          ],
        ),
      ),
    );
  }
}