import 'dart:async';

import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewChallengeReportsBloc {

  Stream<Iterable> get initialState => null;
  Stream<QuerySnapshot> content = FirestoreAPI.getReportedChallenges();

  onReportedChallengeAccepted(Challenge challenge){
    FirestoreAPI.reportedChallengeKeep(challenge.challengeId);
  }

  onReportedChallengeDeclined(Challenge challenge){
    FirestoreAPI.reportedChallengeRemoval(challenge.challengeId);
  }

}