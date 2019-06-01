import 'dart:async';

import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class CreateReminderState {
  String text;
  NotificationFrequency type;
  DateTime date;
  Day day;

  @override
  String toString() {
    return "text: ${text.toString()}\n"
        "type: ${type.toString()}\n"
        "date: ${date.toString()}\n"
        "day: ${day.toString()}\n";
  }

  CreateReminderState({this.text = "", this.type = NotificationFrequency.Once});
}

enum NotificationFrequency { Once, Daily, Weekly }

class CreateReminderBloc {
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' HH:mm"),
    InputType.time: DateFormat("HH:mm"),
  };

  // Changeable in demo
  InputType inputType = InputType.both;
  bool editable = true;

  StreamController<CreateReminderState> createReminderStateController =
      StreamController<CreateReminderState>();

  Sink get updateCreateReminderState => createReminderStateController.sink;

  Stream<CreateReminderState> get stream =>
      createReminderStateController.stream;

  CreateReminderBloc();

  CreateReminderState initial() {
    return CreateReminderState();
  }

  void dispose() {
    createReminderStateController.close();
  }

  void _update(CreateReminderState state) {
    print(state.toString());
    updateCreateReminderState.add(state);
  }

  void updateText(CreateReminderState state, String text) {
    state.text = text;
    _update(state);
  }

  void updateType(CreateReminderState state, NotificationFrequency type) {
    /*// Ensure that we have a date with both date and time.
    if(state.type == NotificationFrequency.Once && type != NotificationFrequency.Once){
      state.date = null;
    }*/
/*
    // Ensure that we have a date with only time.
    if(state.type != NotificationFrequency.Once && type == NotificationFrequency.Once){
      if(state.date.year == null){
        state.date = null;
      }
    }*/
    state.type = type;
    _update(state);
  }

  void updateDate(CreateReminderState state, DateTime date) {
    state.date = date;
    _update(state);
  }

  void updateDay(CreateReminderState state, Day day) {
    state.day = day;
    _update(state);
  }

  String getNotificationText(CreateReminderState state) {
    return state.text.isNotEmpty ? state.text : "Time to work on your goal!";
  }

  InputType getDateInputType(CreateReminderState state) {
    return state.type != NotificationFrequency.Once
        ? InputType.time
        : InputType.both;
  }

  Time getTime(CreateReminderState state) {
    DateTime date = state.date;
    return Time(date.hour, date.minute, date.second);
  }

  Day getDay(CreateReminderState state) {
    return state.day;
  }

  String getDateTimeLabel(CreateReminderState state) {
    return state.type != NotificationFrequency.Once
        ? "Time *"
        : "Date & Time *";
  }

  bool daySelected(CreateReminderState state, Day day) {
    return state.day == day;
  }

  bool showDayPicker(CreateReminderState state) {
    return state.type == NotificationFrequency.Weekly;
  }

  bool isValidated(CreateReminderState state) {
    if (showDayPicker(state)) {
      print(
          "Validation: ${(getDay(state) != null && getTime(state) != null).toString()}");
      print("Day: ${state.day.value.toString()}");
      Time time = getTime(state);
      print(
          "H:${time.hour.toString()}, M:${time.minute.toString()}, S: ${time.second.toString()}");
      return getDay(state) != null && getTime(state) != null;
    } else if (state.type == NotificationFrequency.Daily) {
      Time time = getTime(state);
      print(
          "H:${time.hour.toString()}, M:${time.minute.toString()}, S: ${time.second.toString()}");
      return getTime(state) != null;
    } else {
      DateTime d = state.date;
      print(
          "D:${d?.day.toString() ?? "null"}, M:${d?.month.toString() ?? "null"}, Y:${d?.year.toString() ?? "null"}");
      return state.date != null;
    }
  }

  void registerToFireStore(
      {id, goalId, goalCategory, DateTime timeCreated, DateTime timeToRemind, Day day, type}) {
    FirestoreAPI.registerReminder(
        id: id,
        goalId: goalId,
        goalCategory: goalCategory,
        timeCreated: Timestamp.fromDate(timeCreated),
        timeToRemind: Timestamp.fromDate(timeToRemind),
        day: day != null ? dayToString(day): null,
        type: type);
  }

  String dayToString(Day day){
    if (day.value == 1) return "Sunday";
    if (day.value == 2) return "Monday";
    if (day.value == 3) return "Tuesday";
    if (day.value == 4) return "Wednesday";
    if (day.value == 5) return "Thursday";
    if (day.value == 6) return "Friday";
    if (day.value == 7) return "Saturday";
    return "undefined";
  }

  String formatDate(DateTime date, DateFormat formatter) {
    if (date != null) {
      try {
        return formatter.format(date);
      } catch (e) {
        print('Error formatting date: $e');
      }
    }
    return '';
  }

  String formattedDate(CreateReminderState state) {
    return formatDate(state.date, getDateFormat(state));
  }

  DateFormat getDateFormat(CreateReminderState state) {
    return formats[getDateInputType(state)];
  }
}
