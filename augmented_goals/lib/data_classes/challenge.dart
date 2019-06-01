library undertaking;

import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'challenge.g.dart';

abstract class Challenge implements Built<Challenge, ChallengeBuilder> {
  static Serializer<Challenge> get serializer => _$challengeSerializer;

  String get creatorId;

  String get challengeId;

  String get title;

  String get description;

  GoalCategory get category;

  GeoPoint get position;

  @nullable
  int get timesTaken;

  @nullable
  int get timesCompleted;

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

  @nullable
  String get headerUrl;

  Challenge._();

  static Challenge reportableChallenge(Challenge challenge, DocumentReference reference) {
    ChallengeBuilder b = challenge.toBuilder()
      ..timesFlagged = 1
      ..acceptable = true // until proven otherwise
      ..handled = false
      ..reference = reference;
    return b.build();
  }

  factory Challenge([updates(ChallengeBuilder b)]) = _$Challenge;
}
