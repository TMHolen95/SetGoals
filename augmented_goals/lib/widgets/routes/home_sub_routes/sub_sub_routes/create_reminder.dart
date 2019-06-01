import 'dart:math';

import 'package:augmented_goals/blocs/create_reminder_bloc.dart';
import 'package:augmented_goals/blocs/show_reminder.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/data_classes/reminder.dart';
import 'package:augmented_goals/data_classes/serializers.dart';
import 'package:augmented_goals/main.dart';
import 'package:augmented_goals/widgets/util/frequency_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:augmented_goals/widgets/util/weekday_picker.dart';

class CreateReminder extends StatefulWidget {
  final Goal goal;

  const CreateReminder({Key key, this.goal}) : super(key: key);

  @override
  _CreateReminderState createState() => _CreateReminderState();
}

class _CreateReminderState extends State<CreateReminder> {
  CreateReminderBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CreateReminderBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Reminder"),
        leading: CloseButton(),
      ),
      body: StreamBuilder<CreateReminderState>(
          stream: bloc.stream,
          initialData: bloc.initial(),
          builder: (context, snapshot) {
            CreateReminderState state = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "${widget.goal.title}",
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                  FrequencyPicker(
                      onFrequencySelected: (frequency) =>
                          bloc.updateType(state, frequency)),
                  Visibility(
                      visible: bloc.showDayPicker(state),
                      child: WeekdayPicker(
                        onDaySelected: (day) => bloc.updateDay(state, day),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimePickerFormField(
                        firstDate: DateTime.now().subtract(Duration(days: 1)),
                        initialDate: DateTime.now(),
                        initialValue: state.date,

                        /*controller: TextEditingController(
                          text: bloc.formattedDate(state),

                        ),*/
                        onSaved: (date) => print(date.toString()),
                        inputType: bloc.getDateInputType(state),
                        format: bloc.getDateFormat(state),
                        editable: false,
                        decoration: InputDecoration(
                            labelText: bloc.getDateTimeLabel(state),
                            hasFloatingPlaceholder: true),
                        onChanged: (dt) {
                          bloc.updateDate(state, dt);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (val) => bloc.updateText(state, val),
                      decoration: InputDecoration(
                          labelText: 'Reminder Text',
                          hintText: "Time to work on your goal!",
                          hasFloatingPlaceholder: true),
                    ),
                  ),
                  RaisedButton(
                      child: Text("Set Reminder"),
                      onPressed: () {
                        if (bloc.isValidated(state)) {
                          print("Submitted");
                          scheduleNotification(state, context);
                        }
                      }),
                  ShowReminders(
                    onCancel: (id) => cancelNotification(id),
                    createBloc: bloc,
                    goalId: widget.goal.goalId,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void cancelNotification(int id) {
    LocalNotifications notification = MyApp.of(context);
    notification.plugin.cancel(id);
  }

  VoidCallback scheduleNotification(
      CreateReminderState state, BuildContext context) {
    LocalNotifications notification = MyApp.of(context);
    String notificationText = bloc.getNotificationText(state);
    String notificationTitle = widget.goal.title;

    Future<dynamic> res;

/*    notification.plugin.show(
        326495,
        notificationTitle,
        notificationText,
        //DateTime.now().add(Duration(seconds: 5)),
        notification.notificationDetails);*/
    int id = Random().nextInt(9999999);
    DateTime date = DateTime(0001);
    String type;

    Time time = bloc.getTime(state);
    Day day = bloc.getDay(state);

    if (state.type == NotificationFrequency.Once) {
      res = notification.plugin.schedule(id, notificationTitle,
          notificationText, state.date, notification.notificationDetails);
      date = state.date;
      type = NotificationFrequency.Once.toString();
    } else if (state.type == NotificationFrequency.Daily) {
      res = notification.plugin.showDailyAtTime(id, notificationTitle,
          notificationText, time, notification.notificationDetails);
      //date = addDifference( dt: DateTime.now(), hour: time.hour, minute: time.minute);
      //date = DateTime.utc(2019, 1, 1, time.hour, time.minute).toUtc();
      date = DateTime(2019, 3, 31, time.hour, time.minute).toLocal();
      type = NotificationFrequency.Daily.toString();
    } else if (state.type == NotificationFrequency.Weekly) {
      res = notification.plugin.showWeeklyAtDayAndTime(id, notificationTitle,
          notificationText, day, time, notification.notificationDetails);
      //date = addDifference(dt: DateTime.now(), hour: time.hour, minute: time.minute);
      date = DateTime.utc(2019, 3, 31, time.hour, time.minute).toLocal();
      type = NotificationFrequency.Weekly.toString();
    }

    bloc.registerToFireStore(
        id: id,
        goalId: widget.goal.goalId,
        goalCategory: widget.goal.category,
        timeCreated: DateTime.now(),
        timeToRemind: date,
        day: day,
        type: type);

    return () => res;
  }
}

class ShowReminders extends StatefulWidget {
  final CreateReminderBloc createBloc;
  final String goalId;
  final Function(int) onCancel;

  const ShowReminders({Key key, this.goalId, this.onCancel, this.createBloc})
      : super(key: key);

  @override
  _ShowRemindersState createState() => _ShowRemindersState();
}

class _ShowRemindersState extends State<ShowReminders> {
  ShowReminderBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ShowReminderBloc(widget.goalId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          print("Building!");
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          QuerySnapshot querySnapshot = snapshot.data;
          List<Reminder> reminders = querySnapshot.documents.map((doc) {
            Reminder reminder = mySerializers.deserialize(doc.data);
            return reminder;
          }).toList();

          if (reminders == null || reminders.length == 0) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No reminders set"),
            ));
          }
          CreateReminderBloc b = widget.createBloc;

          return
          ListView(
              children: reminders.map((r) {
                int toTrim = r.type.indexOf(RegExp("[.]")) + 1;
                String type = r.type.substring(toTrim);
                DateTime date = r.timeToRemind.toDate();
                DateFormat f;
                if (type == "Once") {
                  f = DateFormat("EEEE, MMMM d, yyyy 'at' HH:mm");
                } else {
                  f = DateFormat("HH:mm");
                }

                if(type == "Weekly"){
                  type += " at " + r.day;
                }

                String formattedDate = b.formatDate(date, f);
                return ListTile(
                    leading: Icon(Icons.timer),
                    title: Text("Notify at " + formattedDate),
                    subtitle: Text(type),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        widget.onCancel(r.id);
                        bloc.cancel(r.id);
                      },
                    ));

              }).toList(),
              shrinkWrap: true,
              primary: false,);
        });
  }
}

/*class IconDeleted extends StatefulWidget {
  final VoidCallback onPressed;

  const IconDeleted({Key key, this.onPressed}) : super(key: key);

  @override
  _IconDeletedState createState() => _IconDeletedState();
}

class _IconDeletedState extends State<IconDeleted> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return pressed
        ? Text("Deleted")
        : IconButton(
      icon: Icon(Icons.cancel),
      color: Colors.redAccent,
      onPressed: () {
        widget.onPressed();
        setState(() => pressed = true);
      },
    );
  }
}*/
