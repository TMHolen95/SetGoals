import 'dart:async';

import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:augmented_goals/data_classes/enum/goal_status.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:uuid/uuid.dart';

class GoalState {
  String title = "";
  String description = "";
  GoalCategory category;

  bool public = true;

  bool showHelp = false;
  bool allowUpload = true;
  bool checked = false;

  GoalState();
}

class CreateGoalBloc {

  StreamController<GoalState> goalStateController = StreamController<GoalState>();
  Sink get updateGoalState => goalStateController.sink;
  Stream<GoalState> get goalState => goalStateController.stream;

  CreateGoalBloc();

  GoalState initial() {
    return GoalState();
  }

  void dispose(){
    goalStateController.close();
  }

  Goal createGoal(GoalState state) {
    Account account = FirestoreAPI.minimalCurrentAccount();
    print("Account: " + account.toString());
    return Goal((b) => b
      ..goalId = Uuid().v1()
      ..title = state.title
      ..description = state.description
      ..category = state.category
      ..active = false
      ..account = account.toBuilder()
      ..public = state.public
      ..state = GoalStatus.newGoal);
  }

  Future<bool> sendGoalIfValid(GoalState state) async {
    bool sending = false;
    print("Validated");

    if (state.allowUpload) {
      Goal goal = createGoal(state);
      state.allowUpload = false;
      FirestoreAPI.createGoal(goal);
      sending = true;
    }
    state.checked = true;

    updateState(state);

    return sending;
  }

  void closeHelp(GoalState state) {
    state.showHelp = false;
    updateState(state);
  }

  void openHelp(GoalState state) {
    state.showHelp = true;
    updateState(state);
  }

  void updateDescription(GoalState state, String text) {
    state.description = text;
    updateState(state);
  }

  void updateTitle(GoalState state, String text) {
    state.title = text;
    updateState(state);
  }

  void hasBeenChecked(GoalState state) {
    state.checked = true;
    updateState(state);
  }

  void updatePublic(GoalState state) {
    state.public = !state.public;
    updateState(state);
  }

  void updateState(GoalState state){
    updateGoalState.add(state);
  }

  setCategory(GoalState state, GoalCategory category) {
    state.category = category;
  }

  showCategoryFeedback(GoalState state) {
    return state.category == null || state.checked;
  }
}
