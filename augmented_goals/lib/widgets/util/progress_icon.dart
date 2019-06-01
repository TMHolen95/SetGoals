import 'dart:core';
import 'package:augmented_goals/data_classes/enum/goal_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressIcon extends StatelessWidget {
  final GoalStatus status;

  const ProgressIcon({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Icon icon;
    switch (status){
      case GoalStatus.completed:
        icon = Icon(Icons.check, color: Colors.lightGreenAccent);
        break;
      case GoalStatus.progress:
        icon = Icon(Icons.arrow_upward, color: Colors.lightGreen);
        break;
      case GoalStatus.unchanged:
        icon = Icon(Icons.remove, color: Colors.grey);
        break;
      case GoalStatus.setback:
        icon = Icon(Icons.arrow_downward, color: Colors.redAccent);
        break;
      case GoalStatus.failure:
        icon = Icon(Icons.close, color: Colors.red);
        break;
    }
    return icon;
  }
}


