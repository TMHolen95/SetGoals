import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  @required
  final GoalCategory goalCategory;

  final double iconSize;

  final Color color;

  /// Provides a icon that is used as a category.
  ///
  /// Requires a GoalCategory enum.
  /// Optionally provide a size for the icon.
  const CategoryIcon({Key key, this.goalCategory, this.iconSize, this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (goalCategory) {
      case GoalCategory.Academic:
        icon = Icons.school;
        break;
      case GoalCategory.Exercise:
        icon = Icons.directions_run;
        break;
      case GoalCategory.Food:
        icon = Icons.local_dining;
        break;
      case GoalCategory.Fun:
        icon = Icons.mood;
        break;
      case GoalCategory.Hobby:
        icon = Icons.palette;
        break;
      case GoalCategory.Health:
        icon = Icons.healing;
        break;
      case GoalCategory.Romantic:
        icon = Icons.favorite;
        break;
      case GoalCategory.Music:
        icon = Icons.music_note;
        break;
      case GoalCategory.Social:
        icon = Icons.public;
        break;
      case GoalCategory.Work:
        icon = Icons.work;
        break;
      case GoalCategory.Other:
        icon = Icons.help;
        break;
      case GoalCategory.Sightseeing:
        icon = Icons.photo_camera;
        break;
    }
    return Icon(
      icon,
      size: iconSize ?? IconTheme.of(context).size,
      color: color,
    );
  }
}
