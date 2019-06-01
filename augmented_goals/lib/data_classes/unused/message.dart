/*
library message;

import 'package:augmented_goals/data_classes/data.dart';
import 'package:augmented_goals/data_classes/notification.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'message.g.dart';

abstract class Message implements Built<Message, MessageBuilder> {
  static Serializer<Message> get serializer => _$messageSerializer;

  Notification get notification;
  String get token;
  Data get data;

  Message._();

  factory Message([updates(MessageBuilder b)]) = _$Message;
}*/
