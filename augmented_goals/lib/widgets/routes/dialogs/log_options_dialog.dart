import 'package:augmented_goals/blocs/log_options_dialog.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/widgets/list_tiles/checkable_text_field_tile.dart';
import 'package:augmented_goals/widgets/list_tiles/checkable_tile.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:augmented_goals/widgets/util/rounded_icon_button.dart';
import 'package:flutter/material.dart';

/// Creates a dialog for setting what should be logged on a goal.
class LogOptionsDialog extends StatefulWidget {
  @required
  final Goal goal;
  final Function(Goal) onGoalAssignedLogOptions;

  const LogOptionsDialog({Key key, this.goal, this.onGoalAssignedLogOptions})
      : super(key: key);

  @override
  _LogOptionsDialogState createState() => _LogOptionsDialogState();
}

class _LogOptionsDialogState extends State<LogOptionsDialog> {
  CreateLogOptionsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CreateLogOptionsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StreamBuilder<Object>(
          initialData: bloc.initial(),
          stream: bloc.logOptionsState,
          builder: (context, snapshot) {
            LogOptionsState state = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("What do you want to log for this goal?"),
                  ),
                  CheckableTile(
                      iconTextTile: IconTextTile(text: "Daily Check-ins"),
                      checked: state.daily,
                      enabled: (boolean) => bloc.updateDaily(state, boolean)),
                  CheckableTile(
                      iconTextTile: IconTextTile(text: "Duration"),
                      checked: state.duration,
                      enabled: (boolean) =>
                          bloc.updateDuration(state, boolean)),
                  CheckableTextFieldTile(
                    text: "Measurement",
                    checked: state.measurement,
                    inputText: state.unit,
                    enabled: (boolean) =>
                        bloc.updateMeasurement(state, boolean),
                    onTextChange: (text) => bloc.updateUnit(state, text),
                  ),
                  CheckableTile(
                      iconTextTile: IconTextTile(text: "Rating 1-10"),
                      checked: state.performance,
                      enabled: (boolean) =>
                          bloc.updatePerformance(state, boolean)),
                  CheckableTile(
                      iconTextTile: IconTextTile(text: "Reflection Notes"),
                      checked: state.reflection,
                      enabled: (boolean) =>
                          bloc.updateReflection(state, boolean)),
                  Visibility(
                    visible: state.error == null ? false : true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.error ?? ""),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedIconButton(
                      iconData: Icons.check,
                      text: "Submit",
                      onTap: () async {
                        if (bloc.stateSubmittable(state)) {
                          Goal goal = await bloc.attachLogOptionsToGoal(
                            state: state,
                            goal: widget.goal,
                          );
                          widget.onGoalAssignedLogOptions(goal);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}