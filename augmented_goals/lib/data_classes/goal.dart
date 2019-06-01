library goal;

import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/data_classes/enabled_log_options.dart';
import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:augmented_goals/data_classes/enum/goal_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'goal.g.dart';

abstract class Goal implements Built<Goal, GoalBuilder> {
  static Serializer<Goal> get serializer => _$goalSerializer;

  String get goalId;

  String get title;
  @nullable
  String get description;
  GoalCategory get category;

  GoalStatus get state;

  @nullable
  String get goalUrl; // TODO implement the option of having a goal header image

  @nullable
  String get challengeId; // If it was obtained from the map feature

  Account get account;
  bool get public;

  @nullable
  bool get shouldLog;
  @nullable
  String get unit;

  @nullable
  bool get active;

  @nullable
  int get likes;

  @nullable
  Timestamp get dateCreated;
  @nullable
  Timestamp get dateCompleted;

  @nullable
  GeoPoint get position;

  @nullable
  EnabledLogOptions get logOptions;

  Goal._();

  factory Goal([updates(GoalBuilder b)]) = _$Goal;

  static Goal minimal(Goal goal){
    return Goal((builder) => builder
      ..goalId = goal.goalId
      ..title = goal.title
      ..description = goal.description
      ..category = goal.category
      ..public = goal.public);
  }
}



