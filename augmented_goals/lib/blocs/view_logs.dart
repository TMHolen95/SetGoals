import 'dart:core';

import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/data_classes/log_entry.dart';
import 'package:augmented_goals/util/firestore_api.dart';

class ViewLogEntryBloc {
  Goal goal;
  List<LogEntry> _logs;

  List<DateMeasurement> dateMeasurement = [];
  List<DateMeasurement> dateRating = [];
  List<DateDuration> dateDuration = [];
  List<DateNotes> dateNotes = [];
  List<DateCheckIn> dateCheckIn = [];

  ViewLogEntryBloc(Goal goal) {
    this.goal = goal;
  }

  Future<List<LogEntry>> populateLogState() async {
    _logs = await FirestoreAPI.getGoalLogs(goal.goalId);
    print("Log entries: " + _logs.length.toString());
    _logs.forEach((entry) {
      DateTime date = entry.timestamp.toDate();
      if (goal.logOptions.measurement) {
        dateMeasurement.add(DateMeasurement(date, entry.measurement));
      }
      if (goal.logOptions.performance) {
        dateRating
            .add(DateMeasurement(date, entry.performance.roundToDouble()));
      }
      if (goal.logOptions.duration) {
        dateDuration.add(DateDuration(date, entry.duration));
      }
      if (goal.logOptions.reflectiveNotes) {
        String notes = entry.reflectiveNotes.isEmpty
            ? "[No notes]"
            : entry.reflectiveNotes;
        dateNotes.add(DateNotes(date, notes));
      }
      if (goal.logOptions.dailyCheckIn) {
        dateCheckIn.add(DateCheckIn(date));
      }
    });

    if (goal.logOptions.reflectiveNotes) {
      dateNotes.sort((a,b) => b.time.compareTo(a.time));
    }

    return _logs;
  }
}

/// Used for both rating and measurement
class DateMeasurement {
  final DateTime time;
  final double number;

  DateMeasurement(this.time, this.number);
}

class DateDuration {
  final DateTime time;
  final Duration duration;

  DateDuration(this.time, this.duration);
}

class DateNotes {
  final DateTime time;
  final String notes;

  DateNotes(this.time, this.notes);
}

class DateCheckIn {
  final DateTime date;

  DateCheckIn(this.date);
}
