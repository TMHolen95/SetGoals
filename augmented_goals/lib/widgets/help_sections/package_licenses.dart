import 'package:flutter/material.dart';

class PackageLicenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LicensePage()

      ],
    );
  }
}

class License extends StatelessWidget {
  final String packageName;

  const License({Key key, this.packageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        packageName,
      ),
    );
  }
}
