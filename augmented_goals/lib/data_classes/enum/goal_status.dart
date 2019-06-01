library goal_status;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'goal_status.g.dart';


class GoalStatus extends EnumClass {
  static Serializer<GoalStatus> get serializer => _$goalStatusSerializer;

  static const GoalStatus newGoal = _$newGoal;
  static const GoalStatus failure = _$failure;
  static const GoalStatus setback = _$setback;
  static const GoalStatus unchanged = _$unchanged;
  static const GoalStatus progress = _$progress;
  static const GoalStatus completed = _$completed;

  const GoalStatus._(String name) : super(name);

  static BuiltSet<GoalStatus> get values => _$stValues;
  static GoalStatus valueOf(String name) => _$stValueOf(name);

  static List<String> asList(){
    return values.map((GoalStatus status) => asString(status)).toList();
  }

  static String asString(GoalStatus status){
    // Todo use regexp instead as i wont have to maintain a switch case
/*
    var text = status.toString();
    var result = text.replaceAllMapped(RegExp(" /([A-Z])/g"), (Match m) => " $m" );
    return result.substring(0,1).toUpperCase() + result.substring(1);
*/

    switch(status){
      case newGoal:
        return "New Goal";
      case failure:
        return "Failure";
      case setback:
        return "Setback";
      case unchanged:
        return "Unchanged";
      case progress:
        return "Progress";
      case completed:
        return "Completed";

      default:
        return "Error";
    }
  }
}