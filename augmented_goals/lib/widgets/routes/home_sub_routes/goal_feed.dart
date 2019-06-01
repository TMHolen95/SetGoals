import 'package:augmented_goals/blocs/goal_feed_bloc.dart';
import 'package:augmented_goals/widgets/routes/dialogs/modify_goal.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/util/app_bar_actions.dart';
import 'package:augmented_goals/widgets/content_creation/create_goal.dart';
import 'package:augmented_goals/widgets/content_creation/create_post.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/util/navigation_bar.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:augmented_goals/widgets/util/logo_image.dart';
import 'package:augmented_goals/widgets/util/view_goals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GoalFeed extends StatefulWidget {
  @override
  _GoalFeedState createState() => _GoalFeedState();
}

class _GoalFeedState extends State<GoalFeed> implements AppBarActions {
  FilterHandlerBloc bloc;
  Filter state = Filter.all;

  @override
  void initState() {
    super.initState();
    bloc = FilterHandlerBloc();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = ViewGoals(
      onTap: onTap,
      onLongTap: onLongTap,
      stream: bloc.goalStream(state),
      emptyMessage:
          "Your goals will be listed here, to create one tap the + icon.  \n \n"
          "Tip 1: The map feature shows challenges - these can be accepted which adds them to your goal list here.",
    );

    List<WidgetActionPair> widgetActionPair = <WidgetActionPair>[
      WidgetActionPair(
        widget: IconTextTile(iconData: Icons.list, text: "All"),
        onTap: () => setState(() => state = Filter.all),
      ),
      WidgetActionPair(
        widget: IconTextTile(iconData: Icons.sync, text: "Active"),
        onTap: () => setState(() => state = Filter.active),
      ),
      WidgetActionPair(
        widget: IconTextTile(iconData: Icons.new_releases, text: "New"),
        onTap: () => setState(() => state = Filter.newGoal),
      ),
      WidgetActionPair(
        widget: IconTextTile(iconData: Icons.check, text: "Completed"),
        onTap: () => setState(() => state = Filter.completed),
      ),
      WidgetActionPair(
        widget: IconTextTile(iconData: Icons.close, text: "Failed"),
        onTap: () => setState(() => state = Filter.failure),
      ),
    ];

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            leading: HomeImage(Icons.assignment),
            title: Text("Goal List"),
            actions: appBarActions(),
            bottom: TabBar(
              onTap: (number) => widgetActionPair[number].getAction()()
              ,
              isScrollable: true,
              labelPadding: EdgeInsets.all(8.0),
              tabs: widgetActionPair,
            ),
          ),
          bottomNavigationBar: NavigationBar(),
          body: body),
    );
  }

  @override
  List<Widget> appBarActions() {
    var goalFeedAction = <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateGoalForm()),
            );
          })
    ];

    AppBarActions.appendDefaultActions(goalFeedAction, context);
    return goalFeedAction;
  }

  Future<void> onTap(Goal goal, DocumentSnapshot document) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreatePost(
                  goal: goal,
                  goalReference: document,
                )));
  }

  Future<void> onLongTap(Goal goal, DocumentSnapshot document) async {
    showDialog(
        context: context,
        builder: (_) => ModifyGoalDialog(goal: goal,));
  }
}


/// Convenience widget for use in [TabBar]. By using this wrapper it is easier
/// to modify the order of the widgets in the [TabBar] and accessing the
/// correct onTap action from the [TabBar]'s onTap field.
class WidgetActionPair extends StatelessWidget {
  final Widget widget;
  final VoidCallback onTap;

  WidgetActionPair({this.widget, this.onTap});


  /// To use the VoidCallback remember an additional () after calling this
  /// from the [TabBar]'s onTap method.
  /// ex: onTap: () => return widgetActionPair.getAction()();
  VoidCallback getAction() {
    return onTap;
  }

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}
