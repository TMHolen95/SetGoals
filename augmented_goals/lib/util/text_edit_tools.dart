import 'package:flutter/material.dart';

/// Contains tools for handling TextField widgets.
abstract class TextEditTools {
  /// Returns a controller that sets the cursor at the end when text is typed.
  static TextEditingController cursorAtEnd(String value) {
    return TextEditingController.fromValue(TextEditingValue(
        text: value ?? "",
        selection: new TextSelection.collapsed(offset: value?.length ?? 0)));
  }

  /// The default TextField decoration used in the application.
  static InputDecoration defaultDecoration(String text) {
    return InputDecoration(
      helperText: text,
      isDense: true,
      //suffixText: text
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      //helperStyle: TextStyle(fontSize: 10)
    );
  }

}


