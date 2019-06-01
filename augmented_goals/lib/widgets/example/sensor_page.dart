import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({Key key}) : super(key: key);

  @override
  _SensorPageState createState() => new _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  SensorBloc sensorBloc = SensorBloc();

  @override
  Widget build(BuildContext context) {
    final Widget buildBody = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Light Readings"),
          Container(
            child: StreamBuilder(
                stream: sensorBloc.getLightReadingsStream(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Text(snapshot.data.toString())
                      : Text("No data!");
                }),
          ),
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Light sensor test"),
        ),
        body: buildBody);
  }
}

class SensorBloc {
  static const stream = const EventChannel('augmentedgoal.com/light');
  Stream<dynamic> _lightReadings = stream.receiveBroadcastStream();

  Stream getLightReadingsStream() {
    return _lightReadings;
  }
}
