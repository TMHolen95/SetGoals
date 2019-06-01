library account;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'account.g.dart';

abstract class Account implements Built<Account, AccountBuilder> {
  static Serializer<Account> get serializer => _$accountSerializer;

  String get name;
  String get accountPictureUrl;
  String get accountId;

  @nullable
  String get bio;
  @nullable
  String get nickname;
  @nullable
  int get friendCount;
  @nullable
  String get nameLowerCase;
  @nullable
  int get goalsCreated;
  @nullable
  int get goalsCompleted;
  @nullable
  int get postsCreated;

  @nullable
  int get socialPoints;
  @nullable
  int get activityPoints;
  @nullable
  int get creativityPoints;
  @nullable
  bool get bfiTaken;

  @nullable
  BuiltList<String> get questionnairesTaken;

  @nullable
  String get playerType;

  @nullable
  Timestamp get created;

  @nullable
  Timestamp get lastNameChange;

  Account._();

  factory Account([updates(AccountBuilder b)]) = _$Account;

  static Account minimal(Account account) {
    return Account((builder) => builder
      ..accountId = account.accountId
      ..accountPictureUrl = account.accountPictureUrl
      ..name = account.name);
  }
}


/*
List<String> badges;
String bio;
List<String> friends;
Map<String, List<String>> goals;
String name;
String nickname;
Map<String, int> points;
String profilePictureURL;
String uid;
*/
