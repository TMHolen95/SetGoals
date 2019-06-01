import 'dart:async';

import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ChallengeState {
  String title = "";
  String description = "";
  GoalCategory category;

  GeoPoint location;

  bool showHelp = false;
  bool allowUpload = true;
  bool checked = false;

  ChallengeState();
}

class CreateChallengeBloc {

  StreamController<ChallengeState> challengeStateController = StreamController<ChallengeState>();
  Sink get updateChallengeState => challengeStateController.sink;
  Stream<ChallengeState> get challengeState => challengeStateController.stream;

  CreateChallengeBloc();

  ChallengeState initial() {
    return ChallengeState();
  }

  void dispose(){
    challengeStateController.close();
  }

  Challenge createChallenge(ChallengeState state) {
    Account a = FirestoreAPI.account;
    print("Account: " + a.toString());
    return Challenge((b) => b
      ..title = state.title
      ..description = state.description
      ..category = state.category
      ..creatorId = a.accountId
      ..position = state.location
      ..challengeId = Uuid().v1()
    );
  }

  Future<bool> sendChallengeIfValid(ChallengeState state) async {
    bool sending = false;
    print("Validated");

    if (state.allowUpload && state.location != null) {
      Challenge challenge = createChallenge(state);
      state.allowUpload = false;
      FirestoreAPI.createChallenge(challenge);
      sending = true;
    }
    state.checked = true;
    updateState(state);

    return sending;
  }

  void closeHelp(ChallengeState state) {
    state.showHelp = false;
    updateState(state);
  }

  void openHelp(ChallengeState state) {
    state.showHelp = true;
    updateState(state);
  }

  void updateDescription(ChallengeState state, String text) {
    state.description = text;
    updateState(state);
  }

  void updateTitle(ChallengeState state, String text) {
    state.title = text;
    updateState(state);
  }

  void hasBeenChecked(ChallengeState state) {
    state.checked = true;
    updateState(state);
  }

  void updateState(ChallengeState state){
    updateChallengeState.add(state);
  }

  setCategory(ChallengeState state, GoalCategory category) {
    state.category = category;
  }

  showCategoryFeedback(ChallengeState state) {
    return state.category == null || state.checked;
  }

  void setPosition(ChallengeState state, GeoPoint location) {
    state.location = location;
    updateState(state);
  }
}
