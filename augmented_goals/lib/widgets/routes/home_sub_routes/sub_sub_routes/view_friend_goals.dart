import 'package:augmented_goals/blocs/view_friend_goals.dart';
import 'package:augmented_goals/widgets/util/go_back_button.dart';
import 'package:augmented_goals/widgets/util/view_goals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewFriendGoals extends StatefulWidget {
  final String accountId;

  const ViewFriendGoals(this.accountId, {Key key}) : super(key: key);

  @override
  ViewFriendGoalsState createState() {
    return new ViewFriendGoalsState();
  }
}

class ViewFriendGoalsState extends State<ViewFriendGoals> {
  ViewFriendGoalsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ViewFriendGoalsBloc(widget.accountId);
  }

  @override
  Widget build(BuildContext context) {
    final Widget buildBody = ViewGoals(
      stream: bloc.goals,
      showOptions: false,
      emptyMessage: "No public goals yet!",
    );

    return Scaffold(
        appBar: AppBar(
          leading: GoBackButton(),
          title: Text("Goals"),
        ),
        body: buildBody);
  }
}
