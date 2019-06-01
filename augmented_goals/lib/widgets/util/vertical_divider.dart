import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerticalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      child: Center(
        child: Container(
          width: 0.0,
          margin: EdgeInsetsDirectional.only(start: 4.0),
          decoration: BoxDecoration(
            border: Border(
              left: Divider.createBorderSide(context, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}