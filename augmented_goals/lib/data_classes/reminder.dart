library reminder;

import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'reminder.g.dart';

/// TODO Remember to add this to serializers.dart
abstract class Reminder implements Built<Reminder, ReminderBuilder> {
  static Serializer<Reminder> get serializer => _$reminderSerializer;

  int get id;
  String get goalId;
  GoalCategory get goalCategory;
  Timestamp get timeCreated;
  @nullable
  Timestamp get timeToRemind;
  @nullable
  Timestamp get timeCanceled;
  @nullable
  bool get canceled;
  String get type;
  @nullable
  String get day;


  Reminder._();

  factory Reminder([updates(ReminderBuilder b)]) = _$Reminder;
}