import 'package:augmented_goals/blocs/post_feed.dart';
import 'package:augmented_goals/widgets/util/go_back_button.dart';
import 'package:augmented_goals/widgets/util/view_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewFriendPosts extends StatefulWidget {
  final String accountId;

  const ViewFriendPosts(this.accountId, {Key key}) : super(key: key);

  @override
  ViewFriendPostsState createState() {
    return new ViewFriendPostsState();
  }
}

class ViewFriendPostsState extends State<ViewFriendPosts> {
  PostFeedBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PostFeedBloc(accountId: widget.accountId);
  }

  @override
  Widget build(BuildContext context) {
    final Widget buildBody = ViewPosts(
      stream: bloc.posts,
      emptyMessage: "No posts to show!",
    );

    return Scaffold(
        appBar: AppBar(
          leading: GoBackButton(),
          title: Text("Posts"),
        ),
        body: buildBody);
  }
}
