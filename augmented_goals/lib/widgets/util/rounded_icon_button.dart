import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onTap;
  final Color bgColor;
  const RoundedIconButton({Key key, this.onTap, this.text, this.iconData, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(25),
                    color: bgColor ?? Theme.of(context).buttonColor),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: <Widget>[
                      Icon(iconData),
                      Text(text)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
