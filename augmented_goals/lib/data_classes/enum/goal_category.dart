library goal_category;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';

part 'goal_category.g.dart';

class GoalCategory extends EnumClass {
  static Serializer<GoalCategory> get serializer => _$goalCategorySerializer;

  static const GoalCategory Academic = _$Academic;
  static const GoalCategory Exercise = _$Exercise;
  static const GoalCategory Food = _$Food;
  static const GoalCategory Fun = _$Fun;
  static const GoalCategory Hobby = _$Hobby;
  static const GoalCategory Health = _$Health;
  static const GoalCategory Romantic = _$Romantic;
  static const GoalCategory Music = _$Music;
  static const GoalCategory Sightseeing = _$Sightseeing;
  static const GoalCategory Social = _$Social;
  static const GoalCategory Work = _$Work;
  static const GoalCategory Other = _$Other;

  const GoalCategory._(String name) : super(name);

  static BuiltSet<GoalCategory> get values => _$stValues;

  static GoalCategory valueOf(String name) => _$stValueOf(name);

  static Map<GoalCategory, IconData> _map = {
    Academic: Icons.school,
    Exercise: Icons.directions_run,
    Food: Icons.local_dining,
    Fun: Icons.mood,
    Hobby: Icons.palette,
    Health: Icons.healing,
    Romantic: Icons.favorite,
    Music: Icons.music_note,
    Sightseeing: Icons.photo_camera,
    Social: Icons.public,
    Work: Icons.work,
    Other: Icons.help,
  };

  static IconData getIconData(GoalCategory goalCategory) {
    return _map[goalCategory];
  }
}
