/*
library notification;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification.g.dart';

abstract class Notification implements Built<Notification, NotificationBuilder> {
  static Serializer<Notification> get serializer => _$notificationSerializer;

  String get title;
  String get body;

  Notification._();

  factory Notification([updates(NotificationBuilder b)]) = _$Notification;
}*/
