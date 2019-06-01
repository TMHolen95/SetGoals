library friendlist;

import 'package:augmented_goals/data_classes/account.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'friendlist.g.dart';

abstract class FriendList implements Built<FriendList, FriendListBuilder> {
  static Serializer<FriendList> get serializer => _$friendListSerializer;

  BuiltList<Account> get friends; // List with friend uids
  String get accountId;

  FriendList._();

  factory FriendList([updates(FriendListBuilder b)]) = _$FriendList;
}