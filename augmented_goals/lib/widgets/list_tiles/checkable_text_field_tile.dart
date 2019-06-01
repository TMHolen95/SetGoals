import 'package:augmented_goals/widgets/util/toggle_icon.dart';
import 'package:flutter/material.dart';

class CheckableTextFieldTile extends StatelessWidget {
  final String text;
  final bool checked;
  final String inputText;
  final Function(bool) enabled;
  final Function(String) onTextChange;

  const CheckableTextFieldTile(
      {Key key,
        this.text,
        this.checked,
        this.inputText,
        this.enabled,
        this.onTextChange})
      : super(key: key);

  TextEditingController cursorAtEndTextController(String value) {
    return TextEditingController.fromValue(new TextEditingValue(
        text: value,
        selection: new TextSelection.collapsed(offset: value.length)));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Row(
          children: <Widget>[
            Text(text),
            Visibility(
              visible: checked,
              child: Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: cursorAtEndTextController(inputText),
                      decoration: InputDecoration(
                          hintText: " Unit",
                          isDense: true
                      ),
                      onChanged: onTextChange,
                    ),
                  )),
            )
          ],
        ),
        onExpansionChanged: enabled,
        trailing: ToggleIcon(
          state: checked,
          isTrue: Icons.check_box,
          isFalse: Icons.check_box_outline_blank,
          purpose: TogglePurpose.ShowEnabledIcon,
        ));
  }
}