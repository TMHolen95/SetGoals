import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/widgets/util/category_icon.dart';
import 'package:augmented_goals/widgets/util/progress_icon.dart';
import 'package:augmented_goals/widgets/util/account_image.dart';
import 'package:augmented_goals/widgets/util/action_overflow_button.dart';
import 'package:flutter/material.dart';

class GoalHeader extends StatelessWidget {
  final Goal goal;
  final VoidCallback onAccountTap;
  final VoidCallback onGoalTap;
  final List<TitledAction> overflowActions;

  const GoalHeader({Key key, this.goal, this.onAccountTap, this.onGoalTap, this.overflowActions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(padding: EdgeInsets.all(4),),
        ClickableAccountImage(
          url: goal.account.accountPictureUrl,
          onClick: onAccountTap,
        ),
        Expanded(child: GoalInfo(goal: goal, onGoalTap: onGoalTap,)),
        ActionOverflowOptions(titledActions: overflowActions,),
        Container(padding: EdgeInsets.all(4),),

      ],
    );
  }
}

class ClickableAccountImage extends StatelessWidget {
  final VoidCallback onClick;
  final String url;

  const ClickableAccountImage({Key key, this.onClick, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onClick, child: AccountImage(url, round: true,));
  }
}

class GoalInfo extends StatelessWidget {
  final VoidCallback onGoalTap;
  final Goal goal;

  const GoalInfo({Key key, this.onGoalTap, this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onGoalTap,
      child: Card(
        shape: StadiumBorder(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
          CategoryIcon(goalCategory: goal.category,),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(goal.account.name,
                      style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(goal.title, textAlign: TextAlign.center,),
                )
              ],
            ),
          ),
          ProgressIcon(status: goal.state,)
          //getProgressIcon()
        ],),
      ),
    );
  }
}
