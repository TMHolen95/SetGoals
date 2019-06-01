import 'dart:async';

import 'package:augmented_goals/data_classes/enum/goal_status.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/data_classes/log_entry.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class LogEntryState {
  Duration duration = Duration();

  String measurement = "";
  String unit = "";

  bool dailyCheckIn = false;
  int performance = 1;
  String reflectiveNotes = "";

  String error = "";

  LogEntryState();
}

class GoalLoggingBloc {
  StreamController<LogEntryState> logEntryStateController =
  StreamController<LogEntryState>();

  Goal goal;

  Sink get updateLogEntryState => logEntryStateController.sink;

  Stream<LogEntryState> get logEntryState => logEntryStateController.stream;

  GoalLoggingBloc(Goal goal) {
    this.goal = goal;
  }

  LogEntryState initial() {
    return LogEntryState();
  }

  void dispose() {
    logEntryStateController.close();
  }

  updatePoints(LogEntryState state, int value) {
    print("Update: Points updated");
    state.performance = value;
    _update(state);
  }

  void _update(LogEntryState state) {
    updateLogEntryState.add(state);
  }

  updateDailyFeeling(LogEntryState state, bool value) {
    print("Update: DailyFeeling updated");
    state.dailyCheckIn = value;
    _update(state);
  }

  updateReflectionNotes(LogEntryState state, String value) {
    print("Update: ReflectionNotes updated");
    state.reflectiveNotes = value;
    _update(state);
  }

  updateDuration(LogEntryState state, Duration duration) {
    print("Update: Duration updated");
    state.duration = duration;
    print("Duration: ${duration.toString()}");
    _update(state);
  }

  updateCheckedIn(LogEntryState state, bool value) {
    print("Update: CheckedIn updated");
    state.dailyCheckIn = value;
    _update(state);
  }

  /// Returns true if Performance should be used in this LogEntry, or visible in the LogData widget.
  bool enabledPerformance() {
    return goal.logOptions.performance;
  }

  /// Returns true if DailyCheckIn should be used in this LogEntry, or visible in the LogData widget.
  bool enabledDailyCheckIn() {
    return goal.logOptions.dailyCheckIn;
  }

  /// Returns true if ReflectiveNotes should be used in this LogEntry, or visible in the LogData widget.
  bool enabledReflectiveNotes() {
    return goal.logOptions.reflectiveNotes;
  }

  /// Returns true if Duration should be used in this LogEntry, or visible in the LogData widget.
  bool enabledDuration() {
    return goal.logOptions.duration;
  }

  /// Returns true if Measurement should be used in this LogEntry, or visible in the LogData widget.
  bool enabledMeasurement() {
    return goal.logOptions.measurement;
  }

  bool isGoalLogOptionsConfigured() {
    return goal.logOptions != null;
  }

  bool stateSubmittable(LogEntryState state) {
    if (state.performance == 1 &&
        state.dailyCheckIn == false &&
        state.reflectiveNotes.isEmpty &&
        state.duration.inSeconds == 0 &&
        state.measurement.isEmpty) {
      return false;
    }

    return true;
  }

  Future<bool> submit(LogEntryState state) async {
    if (stateSubmittable(state)) {
      // Assign only relevant values to the LogEntry object.
      LogEntryBuilder builder = LogEntryBuilder();

      // Check if the fields is enabled if so set them in the builder.
      // TODO see if this logic can be done in a more proficient way.
      if (enabledPerformance()) builder.performance = state.performance;

      if (enabledDailyCheckIn()) builder.dailyCheckIn = state.dailyCheckIn;

      if (enabledReflectiveNotes())
        builder.reflectiveNotes = state.reflectiveNotes;

      if (enabledDuration()) builder.duration = state.duration;

      if (enabledMeasurement()) {
        try {
          builder.measurement = double.parse(state.measurement);
        } catch (e) {
          builder.measurement = 0;
        }
        builder.measurementUnit = goal.logOptions.measurementUnit;
      }

      builder.entryId = Uuid().v1();
      builder.timestamp = Timestamp.now();

      LogEntry entry = builder.build();
      await FirestoreAPI.addGoalLogEntry(goal.goalId, entry);
      if (goal.active == null || goal.active != true) {
        GoalBuilder builder = goal.toBuilder()
          ..active = true;
        if(goal.state == GoalStatus.newGoal){
          builder.state = GoalStatus.progress;
        }

        await FirestoreAPI.updateGoal(builder.build());
      }

      return true;
    } else {
      state.error = "Please make sure to log at least one criteria.";
      print("Update: error updated");
      _update(state);
      return false;
    }
  }

  void updateUnit(LogEntryState state) {
    try {
      state.unit = goal.logOptions.measurementUnit;
      print("Update: unit updated");
      _update(state);
    } catch (e) {
      print(e);
    }
  }

  updateMeasurement(LogEntryState state, String text) {
    state.measurement = text;
    _update(state);
  }
}
