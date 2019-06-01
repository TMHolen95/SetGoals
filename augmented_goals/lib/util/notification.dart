import 'dart:io';

import 'package:augmented_goals/util/appNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedNotification extends StatefulWidget {
  final bool makeVisible;
  final Map<String, dynamic> message;

  const AnimatedNotification({Key key, this.makeVisible, this.message})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimatedNotificationState();
}

class AnimatedNotificationState extends State<AnimatedNotification> {
  final isIOS = Platform.isIOS;

  @override
  void initState() {
    super.initState();
    //message = mySerializers.deserializeWith(widget.message);
    //data = mySerializers.deserializeWith(Data.serializer, widget.message['data']);
  //  print("Notification JSON: \n" + widget.message['data']);
    //print("Notification serialized: \n" + data.toString());
  }

  @override
  Widget build(BuildContext context) {
    //TODO see if you can get built_value to work with FCM message objects
    String title = isIOS ? widget.message['aps']['alert']['title'] : widget.message['notification']['title'];
    String body = isIOS ? widget.message['aps']['alert']['body'] : widget.message['notification']['body'];

    return GestureDetector(
      onTap: () async {
        print("notification tapped");
        AppNavigator.handleMessage(context, widget.message, onMessage: true);
      },
      child: AnimatedOpacity(
        opacity: widget.makeVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: Notification(
          title: title ?? "Null",
          message: body ?? "Null",
        ),
      ),
    );
  }


}

class Notification extends StatefulWidget {
  final String title;
  final String message;

  const Notification({Key key, this.title, this.message})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 28, 8, 0),
      child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Text(
                  widget.message,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )),
    );
  }
}
