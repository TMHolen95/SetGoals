import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/widgets/list_tiles/text_tile.dart';
import 'package:augmented_goals/widgets/list_tiles/goal_tile.dart';
import 'package:augmented_goals/widgets/util/go_back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewGoalPosts extends StatelessWidget {
  final Goal goal;

  const ViewGoalPosts({Key key, this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO finish
    final relevantPosts = StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.data == null) {
        print("Snapshot does not have data!");
        return CircularProgressIndicator(
          value: 0.0,
        );
      }
      if (snapshot.data.documents.isEmpty) {
        return TextTile(
          message: "No posts on this goal",
        );
      }

      return ListView(
        children: snapshot.data.documents.map((DocumentSnapshot document) {
          return TextTile(
            message: "Test",
          );
        }).toList(),
      );
    });

    final Widget buildBody = Column(
      children: <Widget>[GoalTile(goal: goal, showOptions: false,), relevantPosts],
    );

    return Scaffold(
      appBar: AppBar(
        leading: GoBackButton(),
        title: Text("View Goal"),
      ),
      body: buildBody,
    );
  }
}
