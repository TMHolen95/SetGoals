library comment;

import 'package:augmented_goals/data_classes/account.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'comment.g.dart';

abstract class Comment implements Built<Comment, CommentBuilder> {
  static Serializer<Comment> get serializer => _$commentSerializer;


  String get commentId;
  Account get account;

  @nullable
  String get imageUrl;

  String get message;

  @nullable
  Timestamp get timestamp;

  @nullable
  int get likes;


  @nullable
  int get timesFlagged;

  @nullable
  bool get acceptable;

  @nullable
  bool get handled;

  @nullable
  DocumentReference get reference;

  static Comment reportableComment(Comment comment, DocumentReference reference) {
    CommentBuilder b = comment.toBuilder()
      ..timesFlagged = 1
      ..acceptable = true // until proven otherwise
      ..handled = false
      ..reference = reference;
    return b.build();
  }

  Comment._();

  factory Comment([updates(CommentBuilder b)]) = _$Comment;
}
