import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:augmented_goals/widgets/util/category_icon.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryPicker extends StatefulWidget {
  final Function(GoalCategory) callback;
  final defaultCategory;

  CategoryPicker(this.callback, {this.defaultCategory});

  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  GoalCategory _selection;


  @override
  void initState() {
    super.initState();
    _selection = widget.defaultCategory;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<GoalCategory>(
      items: GoalCategory.values
          .map((GoalCategory value) {
        return DropdownMenuItem<GoalCategory>(
          value: value,
          child: IconTextTile(text: value.name, icon: CategoryIcon(goalCategory: value),),
        );
      }).toList(),
      hint: Text("Category"),
      value: _selection,
      onChanged: (v) {
        setState(() {
          _selection = v;
          widget.callback(v);
        });
      },
    );
  }
}