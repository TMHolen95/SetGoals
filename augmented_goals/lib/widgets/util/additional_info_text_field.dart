import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdditionalInfoTextField extends StatefulWidget {
  final Function(String) onChanged;

  const AdditionalInfoTextField({Key key, this.onChanged}) : super(key: key);

  @override
  AdditionalInfoTextFieldState createState() {
    return new AdditionalInfoTextFieldState();
  }
}

class AdditionalInfoTextFieldState extends State<AdditionalInfoTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (text) => widget.onChanged(text),
        maxLines: 3,
        decoration: InputDecoration(
            hintText:
            'Providing aditional info is optional, but if you choose "Other Reasons" please provide some details',
            helperText: "Additional Info"),
      ),
    );
  }
}