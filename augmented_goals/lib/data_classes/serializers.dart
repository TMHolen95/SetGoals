library serializers;

import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/data_classes/comment.dart';
import 'package:augmented_goals/data_classes/enabled_log_options.dart';
import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:augmented_goals/data_classes/enum/goal_status.dart';
import 'package:augmented_goals/data_classes/friend_request.dart';
import 'package:augmented_goals/data_classes/friendlist.dart';
import 'package:augmented_goals/data_classes/log_entry.dart';
import 'package:augmented_goals/data_classes/question.dart';
import 'package:augmented_goals/data_classes/quiz.dart';
import 'package:augmented_goals/data_classes/reminder.dart';
import 'package:augmented_goals/data_classes/reported_content.dart';
import 'package:augmented_goals/data_classes/serializer_document_reference.dart';
import 'package:augmented_goals/data_classes/serializer_geopoint.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/data_classes/like.dart';
import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/data_classes/serializer_timestamp.dart';

import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'serializers.g.dart';

// remember command for generating data classes: flutter packages pub run build_runner build

@SerializersFor(const [
  Timestamp,
  GeoPoint,
  Post,
  Like,
  GoalStatus,
  GoalCategory,
  Goal,
  Comment,
  EnabledLogOptions,
  BuiltMap,
  BuiltList,
  Account,
  FriendRequest,
  FriendList,
  Quiz,
  Question,
  Challenge,
  Reminder,
  LogEntry,
  ReportedContent
])
final Serializers serializers = _$serializers;

final mySerializers = (serializers.toBuilder()
  ..add(TimestampSerializer())
  ..add(GeoPointSerializer())
  ..add(DocumentReferenceSerializer())
  ..addPlugin(StandardJsonPlugin()))
    .build();
