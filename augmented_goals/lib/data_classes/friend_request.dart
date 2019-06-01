library friend_request;

import 'package:augmented_goals/data_classes/account.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'friend_request.g.dart';

abstract class FriendRequest implements Built<FriendRequest, FriendRequestBuilder> {
  static Serializer<FriendRequest> get serializer => _$friendRequestSerializer;

  Account get sender;
  Account get recipient;
  @nullable
  bool get accepted;
  Timestamp get timestamp;

  FriendRequest._();

  factory FriendRequest([updates(FriendRequestBuilder b)]) = _$FriendRequest;
}