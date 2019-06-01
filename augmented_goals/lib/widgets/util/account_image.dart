import 'package:flutter/material.dart';

class AccountImage extends StatelessWidget {
  final String url;
  final bool round;
  final double width;
  final double height;

  const AccountImage(this.url,
      {Key key, this.round, this.width = 50, this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShapeBorder border = round ?? false ? CircleBorder() : Border.all();

    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: border,
        color: Colors.white,
      ),
      child: url.toLowerCase().startsWith("http")
          ? Image.network(url, width: width, height: height,)
          : Icon(
              Icons.person,
              color: Colors.blue,
              size: 40,
            ),
    );
  }
}
