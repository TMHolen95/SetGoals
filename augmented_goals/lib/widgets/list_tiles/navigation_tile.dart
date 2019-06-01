import 'package:flutter/material.dart';

class NavigationTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const NavigationTile({Key key, this.onTap, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border.all(color: Colors.black),
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
