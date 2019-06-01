
import 'package:augmented_goals/blocs/duration_picker.dart';
import 'package:augmented_goals/util/text_edit_tools.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:flutter/material.dart';

class DurationPicker extends StatefulWidget {
  final Function(Duration) onDuration;

  const DurationPicker({Key key, this.onDuration}) : super(key: key);

  @override
  _DurationPickerState createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  DurationPickerBloc bloc;
  Duration prevDuration = Duration();

  FocusNode _hours;
  FocusNode _minutes;
  FocusNode _seconds;
  @override
  void initState() {
    super.initState();
    bloc = DurationPickerBloc();

    _hours = new FocusNode();
    _minutes = new FocusNode();
    _seconds = new FocusNode();
  }

  _unfocus() {
    _hours.unfocus();
    _minutes.unfocus();
    _seconds.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();

    _hours.dispose();
    _minutes.dispose();
    _seconds.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      initialData: bloc.initial(),
      stream: bloc.durationState,
      builder: (context, snapshot) {
        DurationState state = snapshot.data;

        if(state.duration != prevDuration){
          widget.onDuration(state.duration);
        }
        prevDuration = state.duration;

        return ExpansionTile(
          onExpansionChanged: (value) {
            _unfocus();
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconTextTile(
                text: "Duration",
                iconData: Icons.timer,
              ),
              Text(bloc.showFormattedDurationIfSet(state))
            ],
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: TextEditTools.cursorAtEnd(state.hours),
                      decoration: TextEditTools.defaultDecoration("Hours"),
                      onChanged: (value) {
                        if (value.length == 2) {
                          bloc.updateMinutes(state, "");
                          FocusScope.of(context).requestFocus(_minutes);
                        }
                        return bloc.updateHours(state, value);
                      },
                      onTap: () => bloc.updateHours(state, ""),
                      focusNode: _hours,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  Flexible(
                    child: TextField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: TextEditTools.cursorAtEnd(state.minutes),
                      decoration: TextEditTools.defaultDecoration("Minutes"),
                      onChanged: (value) {
                        if (value.length == 2) {
                          bloc.updateSeconds(state, "");
                          FocusScope.of(context).requestFocus(_seconds);
                        }
                        if (value.length == 0 && state.minutes.isEmpty) {
                          FocusScope.of(context).requestFocus(_hours);
                        }
                        return bloc.updateMinutes(state, value);
                      },
                      onTap: () => bloc.updateMinutes(state, ""),
                      focusNode: _minutes,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  Flexible(
                    child: TextField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: TextEditTools.cursorAtEnd(state.seconds),
                      decoration: TextEditTools.defaultDecoration("Seconds"),
                      onChanged: (value) {
                        print(value);
                        if (value.length == 0 && state.seconds.isEmpty) {
                          FocusScope.of(context).requestFocus(_minutes);
                        }
                        return bloc.updateSeconds(state, value);
                      },
                      onTap: () => bloc.updateSeconds(state, ""),
                      focusNode: _seconds,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}