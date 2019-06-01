import 'dart:async';

import 'package:augmented_goals/data_classes/enabled_log_options.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/util/firestore_api.dart';

class LogOptionsState {
  bool daily = false;
  bool duration = false;
  bool measurement = false;
  String unit = "";
  bool performance = false;
  bool reflection = false;

  String error;

  LogOptionsState();
}

class CreateLogOptionsBloc {
  StreamController<LogOptionsState> logOptionsStateController =
      StreamController<LogOptionsState>();

  Sink get updateLogOptionsState => logOptionsStateController.sink;

  Stream<LogOptionsState> get logOptionsState =>
      logOptionsStateController.stream;

  CreateLogOptionsBloc();

  LogOptionsState initial() {
    return LogOptionsState();
  }

  void dispose() {
    logOptionsStateController.close();
  }

  void _update(LogOptionsState state) {
    updateLogOptionsState.add(state);
  }

  void updateDaily(LogOptionsState state, bool daily) {
    state.daily = daily;
    _update(state);
  }

  void updateDuration(LogOptionsState state, bool duration) {
    state.duration = duration;
    _update(state);
  }

  void updateMeasurement(LogOptionsState state, bool measurement) {
    state.measurement = measurement;
    _update(state);
  }

  void updatePerformance(LogOptionsState state, bool performance) {
    state.performance = performance;
    _update(state);
  }

  void updateReflection(LogOptionsState state, bool reflection) {
    state.reflection = reflection;
    _update(state);
  }

  /// If the goal doesn't have information on what should be logged in
  /// goal.logOption then this method will update the goal in the DB
  Future<Goal> attachLogOptionsToGoal(
      {LogOptionsState state, Goal goal}) async {
    EnabledLogOptionsBuilder options = EnabledLogOptionsBuilder()
      ..dailyCheckIn = state.daily
      ..duration = state.duration
      ..measurement = state.measurement
      ..performance = state.performance
      ..reflectiveNotes = state.reflection;

    if(state.measurement){
      options.measurementUnit = state.unit;
    }

    GoalBuilder goalBuilder = goal.toBuilder()..logOptions = options;
    goal = goalBuilder.build();

    await FirestoreAPI.attachLogOptionsToGoal(goal);

    return goal;
  }

  void updateUnit(LogOptionsState state, String text) {
    state.unit = text;
    _update(state);
  }

  bool stateSubmittable(LogOptionsState state) {
    if (state.measurement && state.unit.isEmpty) {
      state.error =
          "Measurement requires a countable unit for the goal, such as meters or laps.";
      _update(state);
      return false;
    } else if (!state.daily &&
        !state.duration &&
        !state.measurement &&
        !state.performance &&
        !state.reflection) {
      state.error = "Select at least one logging criteria";
      _update(state);
      return false;
    } else {
      print("State submittable");
      return true;
    }
  }
}
