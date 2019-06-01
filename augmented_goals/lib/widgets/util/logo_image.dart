import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeImage extends StatelessWidget {
  @required
  final IconData iconData;
  const HomeImage(this.iconData,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(iconData,
            color: Colors.blue,
            size: 40,),
        ),
        decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.white,),
      ),
    );
  }
}