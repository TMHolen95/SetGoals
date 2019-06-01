import 'package:augmented_goals/blocs/comment_section.dart';
import 'package:augmented_goals/data_classes/comment.dart';
import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/data_classes/serializers.dart';
import 'package:augmented_goals/widgets/list_tiles/comment_tile.dart';
import 'package:augmented_goals/widgets/util/list_helper.dart';
import 'package:augmented_goals/widgets/util/toggle_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommentSection extends StatefulWidget {
  final Post post;

  const CommentSection({Key key, this.post}) : super(key: key);

  @override
  CommentSectionState createState() {
    return new CommentSectionState();
  }
}

class CommentSectionState extends State<CommentSection> {
  CommentBloc bloc;
  TextEditingController controller = TextEditingController();
  CommentingState lastState;
  @override
  void initState() {
    super.initState();
    bloc = CommentBloc(widget.post);
    controller.addListener(() {
      print("Changed: ${controller.value.text}");
      bloc.updateComment(lastState, controller.value.text);
    });

  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget comments = StreamBuilder(
        stream: bloc.commentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListHelper.prePopulatedListCases(
                  snapshot, "No comments yet, be the first!") ??
              Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    snapshot.data.documents.map((DocumentSnapshot snapshot) {
                  Comment comment = mySerializers.deserialize(snapshot.data);
                  return CommentTile(
                    post: widget.post,
                    comment: comment,
                  );
                }).toList(),
              );
        });

    final Widget commentField = Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<CommentingState>(
          stream: bloc.stream,
          initialData: bloc.initial(),
          builder: (context, snapshot) {
            lastState = snapshot.data;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: "Write a comment...",
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    controller: controller,
                    autovalidate: true,
                  ),
                ),
                IconButton(
                    icon: ToggleIcon(
                      state: lastState.commentingAllowed,
                      isFalse: Icons.send,
                      isTrue: Icons.send,
                      purpose: TogglePurpose.ShowEnabledIcon,
                    ),
                    onPressed: () {
                      if (lastState.commentingAllowed) {
                        bloc.sendComment(lastState);
                        controller.clear();
                      }
                    })
              ],
            );
          }),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[comments, commentField],
      ),
    );
  }
}
