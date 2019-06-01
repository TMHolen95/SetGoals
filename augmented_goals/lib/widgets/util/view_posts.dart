import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/data_classes/serializers.dart';
import 'package:augmented_goals/widgets/list_tiles/text_tile.dart';
import 'package:augmented_goals/widgets/list_tiles/post_tile.dart';
import 'package:augmented_goals/widgets/util/list_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewPosts extends StatefulWidget {
  final Stream<QuerySnapshot> stream;
  final String emptyMessage;

  const ViewPosts({Key key, this.stream, this.emptyMessage}) : super(key: key);

  @override
  ViewPostsState createState() {
    return ViewPostsState();
  }
}

class ViewPostsState extends State<ViewPosts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return ListHelper.prePopulatedListCases(snapshot, widget.emptyMessage) ??
            ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                //print("Snapshot data: " + document.data.toString());
                if (document.data == null) {
                  return TextTile(
                    message:
                        "Welcome to Augmented Goals!\n Your feed is currently empty",
                  );
                }
                //print(document.data.toString());
                Post post = mySerializers.deserializeWith(
                    Post.serializer, document.data);
                return PostTile(
                  key: UniqueKey(),
                  post: post,
                  truncate: false,
                  showCommentSection: false,
                );
              }).toList(),
            );
      },
    );
  }
}
