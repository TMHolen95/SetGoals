import 'dart:async';

import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/util/firestore_api.dart';

class ModifyGoalState {
  String title;
  String description;
  GoalCategory category;
  String error = "";
  bool public;

  ModifyGoalState(String title, String description, GoalCategory category, bool public) {
    this.title = title;
    this.description = description;
    this.category = category;
    this.public = public;
  }
}

class ModifyGoalBloc {
  Goal initialGoal;

  StreamController<ModifyGoalState> modifyGoalStateController =
      StreamController<ModifyGoalState>();

  Sink get updateModifyGoalState => modifyGoalStateController.sink;

  Stream<ModifyGoalState> get stream => modifyGoalStateController.stream;

  ModifyGoalBloc();

  ModifyGoalState initial(Goal initialGoal) {
    this.initialGoal = initialGoal;
    return ModifyGoalState(
        initialGoal.title, initialGoal.description, initialGoal.category, initialGoal.public);
  }

  void dispose() {
    modifyGoalStateController.close();
  }

  void _update(ModifyGoalState state) {
    updateModifyGoalState.add(state);
  }

  void updateTitle(ModifyGoalState state, String title) {
    state.title = title;
    _update(state);
  }

  void updateDescription(ModifyGoalState state, String description) {
    state.description = description;
    _update(state);
  }

  void updateCategory(ModifyGoalState state, GoalCategory category) {
    state.category = category;
    _update(state);
  }

  void updateError(ModifyGoalState state, String error) {
    state.error = error;
    _update(state);
  }

  Future<bool> onSubmit(ModifyGoalState state) async {
    if (validated(state)) {
      print("Submit is validated");
      Goal goal = updateGoal(state);
      await FirestoreAPI.updateGoal(goal);
      return Future.value(true);
    } else {
      updateError(state, "Please ensure that the goal have a title!");
      return Future.value(false);
    }
  }

  bool validated(ModifyGoalState state) {
    return state.title.length != 0;
  }

  Goal updateGoal(ModifyGoalState state) {
    GoalBuilder builder = initialGoal.toBuilder()
      ..title = state.title
      ..description = state.description
      ..public = state.public
      ..category = state.category;

    return builder.build();
  }

  Future deleteGoal() {
    return FirestoreAPI.deleteGoal(initialGoal.goalId);
  }

  void updatePublic(ModifyGoalState state, bool value) {
    state.public = value;
    _update(state);
  }
}
