import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/widgets/list_tiles/post_tile.dart';
import 'package:augmented_goals/widgets/util/go_back_button.dart';
import 'package:flutter/material.dart';

class ViewFullPost extends StatefulWidget {
  final Post post;
  const ViewFullPost({Key key, this.post}) : super(key: key);

  @override
  ViewFullPostState createState() {
    return ViewFullPostState();
  }
}

class ViewFullPostState extends State<ViewFullPost> {
  @override
  Widget build(BuildContext context) {

    final Widget buildBody = SingleChildScrollView(child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        PostTile(
          post: widget.post,
          truncate: false,
          showCommentSection: true,
        ),
      ],
    ));

    return Scaffold(
      appBar: AppBar(
        leading: GoBackButton(),
        title: Text("View Post"),
      ),
      body: buildBody,
    );

  }
}