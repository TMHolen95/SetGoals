import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/data_classes/serializers.dart';
import 'package:augmented_goals/widgets/list_tiles/goal_tile.dart';
import 'package:augmented_goals/widgets/util/list_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewGoals extends StatelessWidget {
  final Stream<QuerySnapshot> stream;
  final String emptyMessage;
  final bool showOptions;
  final Function(Goal goal, DocumentSnapshot snapshot) onTap;
  final Function(Goal goal, DocumentSnapshot snapshot) onLongTap;

  const ViewGoals(
      {Key key,
      this.stream,
      this.emptyMessage,
      this.onTap,
      this.onLongTap,
      this.showOptions = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        print("Goal List built");
        return ListHelper.prePopulatedListCases(snapshot, emptyMessage) ??
            ListView(
              children:
              snapshot.data.documents.map((DocumentSnapshot document) {
                print(document.data);
                Goal goal = mySerializers.deserializeWith(
                    Goal.serializer, document.data);
                return GoalTile(
                  goal: goal,
                  showOptions: showOptions,
                  onTap: () => onTap(goal, document),
                  onLongTap: () => onLongTap(goal, document),
                );
              }).toList(),
            );
      },
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // ... (Omitted code for when snapshot is null or empty)
        return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            print(document.data);
            Goal goal = mySerializers.deserializeWith(Goal.serializer, document.data);
            return GoalTile(
              goal: goal,
              showOptions: showOptions,
              onTap: () => onTap(goal, document),
              onLongTap: () => onLongTap(goal, document),
            );
          }).toList(),
        );
      },
    );
  }*/
}
