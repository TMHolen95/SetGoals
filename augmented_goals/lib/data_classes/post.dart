library post;

import 'package:augmented_goals/data_classes/goal.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'post.g.dart';

abstract class Post implements Built<Post, PostBuilder> {
  static Serializer<Post> get serializer => _$postSerializer;
  String get postId;

  //Account get account; // Account already exists within goal
  Goal get goal;

  @nullable
  String get fileName;
  @nullable
  int get width;
  @nullable
  int get height;

  @nullable
  BuiltList<String> get uids;

  String get title;
  String get message;

  Timestamp get timestamp;
  @nullable
  int get commentCount;
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

  static Post reportablePost(Post post, DocumentReference reference) {
    PostBuilder b = post.toBuilder()
      ..timesFlagged = 1
      ..acceptable = true // until proven otherwise
      ..handled = false
      ..reference = reference;
    return b.build();
  }

  Post._();

  factory Post([updates(PostBuilder b)]) = _$Post;
}

