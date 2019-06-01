import 'package:augmented_goals/blocs/log_data.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/util/text_edit_tools.dart';
import 'package:augmented_goals/widgets/list_tiles/checkable_tile.dart';
import 'package:augmented_goals/widgets/routes/dialogs/log_options_dialog.dart';
import 'package:augmented_goals/widgets/util/duration_picker.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:augmented_goals/widgets/util/rounded_icon_button.dart';
import 'package:flutter/material.dart';

class GoalLogging extends StatefulWidget {
  final Goal goal;

  const GoalLogging({Key key, this.goal}) : super(key: key);

  @override
  _GoalLoggingState createState() => _GoalLoggingState();
}

class _GoalLoggingState extends State<GoalLogging> {
  GoalLoggingBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = GoalLoggingBloc(widget.goal);
  }

  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        initialData: bloc.initial(),
        stream: bloc.logEntryState,
        builder: (context, snapshot) {
          LogEntryState state = snapshot.data;
          if (bloc.goal == null) {
            return CircularProgressIndicator();
          }
          if (state.unit?.isEmpty ?? false) {
            bloc.updateUnit(state);
          }
          Widget body;
          if (bloc.isGoalLogOptionsConfigured()) {
            body = selectedLogOptions(state, bloc);
          } else {
            body = LogOptionsDialog(
              goal: bloc.goal,
              onGoalAssignedLogOptions: (goal) => bloc.goal = goal,
            );
          }

          return Scaffold(
              appBar: AppBar(
                title: IconTextTile(
                  text: "New Log Entry",
                  iconData: Icons.edit,
                ),
              ),
              body: body);
        });
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  Widget selectedLogOptions(LogEntryState state, GoalLoggingBloc bloc) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
              visible: bloc.enabledDailyCheckIn(),
              child: dailyGoalTile(state, bloc)),
          Visibility(
              visible: bloc.enabledDuration(),
              child: DurationPicker(
                  onDuration: (duration) {
                    print("On duration triggered!");
                    return bloc.updateDuration(state, duration);
                  })),
          Visibility(
              visible: bloc.enabledMeasurement(),
              child: measurementTile(state, bloc)),
          Visibility(
              visible: bloc.enabledPerformance(),
              child: performanceTile(state, bloc)),
          Visibility(
              visible: bloc.enabledReflectiveNotes(),
              child: reflectiveNotesTile(state, bloc)),
          Visibility(
            visible: state.error.isNotEmpty,
            child: Text(state.error),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedIconButton(
              text: "Submit",
              iconData: Icons.check,
              onTap: () async {
                if ((await bloc.submit(state))) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  ExpansionTile measurementTile(LogEntryState state, GoalLoggingBloc bloc) {
    return ExpansionTile(
      title: IconTextTile(
        text: "Measurement",
        iconData: Icons.timeline,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) => bloc.updateMeasurement(state, text),
                  controller: TextEditTools.cursorAtEnd(state.measurement),
                  decoration: TextEditTools.defaultDecoration("${state.unit}"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  CheckableTile dailyGoalTile(LogEntryState state, GoalLoggingBloc bloc) {
    return CheckableTile(
      enabled: (value) => bloc.updateCheckedIn(state, value),
      checked: state.dailyCheckIn,
      iconTextTile: IconTextTile(
        iconData: Icons.check,
        text: "Daily Check-in",
      ),
    );
  }

  ExpansionTile performanceTile(LogEntryState state, GoalLoggingBloc bloc) {
    return ExpansionTile(
      title: IconTextTile(
        text: "Performance 1-10",
        iconData: Icons.linear_scale,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Your daily performance"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("Low"),
              Expanded(
                child: Slider(
                  onChanged: (val) {
                    bloc.updatePoints(state, val.round());
                  },
                  value: state.performance.roundToDouble() ?? 5,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: state.performance?.round().toString() ?? "Unset",
                ),
              ),
              Text("High"),
            ],
          ),
        )
      ],
    );
  }

  ExpansionTile reflectiveNotesTile(LogEntryState state, GoalLoggingBloc bloc) {
    return ExpansionTile(
      title: IconTextTile(
        text: "Reflective Notes",
        iconData: Icons.lightbulb_outline,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Reflect to find factors that help or counteract your goal progress. Decide if these factors should be kept or eliminated for future work on your goal."),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 5,
                  onChanged: (text) => bloc.updateReflectionNotes(state, text),
                  decoration: TextEditTools.defaultDecoration("Reflection"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
