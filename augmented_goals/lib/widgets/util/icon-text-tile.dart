import 'package:augmented_goals/widgets/util/category_icon.dart';
import 'package:flutter/material.dart';

/// Displays a row with a Icon and a Text with padding between.
///
/// A [Text] must be provided. Either a [IconData] or a [CategoryIcon] can be
/// provided, if both are specified iconData takes precedence. If none of these
/// are specified this function is equivalent to Text(textVariable).
class IconTextTile extends StatelessWidget {
  final IconData iconData;
  final CategoryIcon icon;
  @required
  final String text;

  const IconTextTile({Key key, this.iconData, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iconData != null || icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            iconData != null ? Icon(iconData) : icon,
            Padding(
              padding: EdgeInsets.all(4.0),
            ),
            Flexible(child: Text(text))
          ],
      );
    } else {
      return Text(text);
    }
  }
}
