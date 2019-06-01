import 'package:augmented_goals/blocs/post-tile.dart';
import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/util/appNavigation.dart';
import 'package:augmented_goals/widgets/routes/dialogs/confirm_dialog.dart';
import 'package:augmented_goals/widgets/util/action_overflow_button.dart';
import 'package:augmented_goals/widgets/util/goal_header.dart';
import 'package:augmented_goals/widgets/util/comment_section.dart';
import 'package:augmented_goals/widgets/util/firestore_image.dart';
import 'package:augmented_goals/widgets/util/report_dialog.dart';
import 'package:augmented_goals/widgets/util/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final bool truncate;
  final bool showCommentSection;

  const PostTile({Key key, this.post, this.truncate, this.showCommentSection})
      : super(key: key);

  @override
  PostTileState createState() {
    return PostTileState();
  }
}

class PostTileState extends State<PostTile> {
  List<TitledAction> actions;
  PostTileBloc bloc;
  VoidCallback onAccountTap;
  VoidCallback onImageTap;
  VoidCallback onGoalTap;
  Function(String, String) onReport;

  @override
  void initState() {
    super.initState();
    bloc = PostTileBloc(widget.post);

    onAccountTap = () async {
      await AppNavigator.account(context, widget.post.goal.account.accountId);
    };
    onGoalTap = () async {
      await AppNavigator.goalPosts(context, widget.post.goal);
    };
    onImageTap = () async {
      if (!widget.showCommentSection) {
        await AppNavigator.fullPost(context, widget.post);
      } else {
        // TODO zoom picture.
      }
    };

    actions = <TitledAction>[
      // TODO Options for subscribing and unsubscribing to a post for updates
      TitledAction("Report Post", () => _showReportDialog())
    ];
    if (bloc.isPostOwner()) {
      actions.add(TitledAction("Delete Post", () => _showDeleteDialog()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentSection = !widget.showCommentSection
        ? Container()
        : CommentSection(post: widget.post);

    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GoalHeader(
              goal: widget.post.goal,
              onAccountTap: onAccountTap,
              onGoalTap: onGoalTap,
              overflowActions: actions,
            ),
            MainPostContent(
              bloc: bloc,
              onTap: onImageTap,
            ),
            Divider(
              color: Colors.black,
            ),
            commentSection
          ],
        ),
      ],
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return ReportDialog(post: widget.post);
      },
    );
  }

  _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          title: "Delete Post",
          onConfirm: () => bloc.deletePost(widget.post.postId),
          text: "This action can not be undone!",
        );

        /*return DeleteDialog(
          content: "Test",
          reference: bloc.postReference(),
        );*/
      },
    );
  }
}

class MainPostContent extends StatelessWidget {
  final PostTileBloc bloc;
  final VoidCallback onTap;

  const MainPostContent({Key key, this.bloc, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Headline(bloc.post.title),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  bloc.post.message,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Visibility(
                visible: bloc.post.fileName != null,
                child: AspectRatio(
                  aspectRatio: (bloc.post.width ?? 1) / (bloc.post.height ?? 1),
                  child: FirestoreImage(
                      key: UniqueKey(), reference: bloc.imageReference() ?? null),
                ),
              ),
            ],
          ),
        ));
  }
}
