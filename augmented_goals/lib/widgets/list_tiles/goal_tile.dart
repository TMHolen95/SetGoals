import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/util/appNavigation.dart';
import 'package:augmented_goals/widgets/util/category_icon.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io' show Platform;
class GoalTile extends StatelessWidget {
  final Goal goal;
  final VoidCallback onTap;
  final VoidCallback onLongTap;
  final bool showOptions;

  const GoalTile({Key key, this.goal, this.onTap, this.onLongTap, this.showOptions = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> options = [
      FlatButton(child: IconTextTile(text: 'Create Post', iconData: Icons.image,), onPressed: onTap,),
      FlatButton(child: IconTextTile(text: 'Logg Data', iconData: Icons.mode_edit,), onPressed: () => AppNavigator.goalLogging(context, goal),),
      FlatButton(child: IconTextTile(text: 'View Data', iconData: Icons.timeline,), onPressed: () => AppNavigator.viewGoalLogs(context, goal),),
    ];
    //if(!Platform.isIOS){
      options.add(FlatButton(child: IconTextTile(text: 'Reminders', iconData: Icons.timer,), onPressed: () => AppNavigator.createReminder(context, goal),));
    //}
    options.add(FlatButton(child: IconTextTile(text: 'Modify Goal', iconData: Icons.settings,), onPressed: onLongTap,));

    return Card(
      child: ExpansionTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CategoryIcon(goalCategory: goal.category,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  goal.title,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
            ),

          ],
        ),

        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16,0,16,8),
                  child: Text("Description:", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16,0,16,16),
                  child: Text(goal.description, textAlign: TextAlign.start,),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,16,16),
                    child: IconTextTile(iconData: goal.public ? Icons.public : Icons.lock, text: goal.public ? "Public" : "Private",),
                  ),
                ),
                Visibility(
                  visible: showOptions,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: options,
                  ),
                )

              ],
            ),
          ),

        ],
      ),
    );
  }
}



