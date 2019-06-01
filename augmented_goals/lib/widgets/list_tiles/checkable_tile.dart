import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:augmented_goals/widgets/util/toggle_icon.dart';
import 'package:flutter/material.dart';

class CheckableTile extends StatelessWidget {
  final IconTextTile iconTextTile;
  final bool checked;
  final Function(bool) enabled;

  const CheckableTile({Key key, this.checked, this.enabled, this.iconTextTile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: iconTextTile,
        onExpansionChanged: enabled,
        trailing: ToggleIcon(
          state: checked,
          isTrue: Icons.check_box,
          isFalse: Icons.check_box_outline_blank,
          purpose: TogglePurpose.ShowEnabledIcon,
        ));
  }
}