import 'dart:async';

import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/util/firestore_api.dart';

class AcceptState{
    String message = "";
    bool accepted = false;
    bool inGoalList;
    bool reported = false;
    AcceptState();
}

class QuickViewChallengeBloc{
  StreamController<AcceptState> acceptStateController = StreamController<AcceptState>();
  Sink get updateAcceptState => acceptStateController.sink;
  Stream<AcceptState> get acceptState => acceptStateController.stream;

  QuickViewChallengeBloc();

  AcceptState initial(){
    return AcceptState();
  }

  void dispose(){
    acceptStateController.close();
  }

  void _update(AcceptState state){
    updateAcceptState.add(state);
  }

  Future<bool> checkGoalList(AcceptState state, Challenge challenge) async {
    bool result = await FirestoreAPI.goalListContains(challenge.challengeId);
    print("Result: ${result.toString()}");
    result ? state.message = "Already Added" : state.message = "Accept Challenge";
    state.inGoalList = result;
    _update(state);
    return result;
  }

  onReport(AcceptState state, Challenge challenge){
    state.reported = true;
    state.message = "Report Submitted";
    _update(state);
  }

  onChallengeAccepted(AcceptState state, Challenge challenge) async {
    if(!state.inGoalList && !state.reported){
      print("Adding");
      await FirestoreAPI.addChallengeToUserGoalList(challenge);
      state.message = "Challenge Added!";
      _update(state);
    }
  }

  Future<void> deleteChallenge(Challenge challenge) async {
    await FirestoreAPI.deleteChallenge(challenge);
  }

  bool isChallengeCreator(Challenge challenge){
    return FirestoreAPI.account.accountId == challenge.creatorId;
  }

  /// Needed for when a challenge is deleted
  void update(AcceptState state) {
    _update(state);
  }

}