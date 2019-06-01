
import 'package:augmented_goals/blocs/create_reminder_bloc.dart';
import 'package:augmented_goals/widgets/util/option_button.dart';
import 'package:flutter/material.dart';

class FrequencyPicker extends StatefulWidget {
  final Function(NotificationFrequency) onFrequencySelected;

  const FrequencyPicker({Key key, this.onFrequencySelected}) : super(key: key);

  @override
  _FrequencyPickerState createState() => _FrequencyPickerState();
}

class _FrequencyPickerState extends State<FrequencyPicker> {
  NotificationFrequency frequency = NotificationFrequency.Once;

  void setFrequency(NotificationFrequency frequency){
    setState(() => this.frequency = frequency);
    widget.onFrequencySelected(frequency);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Reminder frequency:"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OptionButton(
                  onPressed: () => setFrequency(NotificationFrequency.Once),
                  text: "Once",
                  selected: frequency == NotificationFrequency.Once
              ),
              OptionButton(
                onPressed: () => setFrequency(NotificationFrequency.Daily),
                text: "Daily",
                selected: frequency == NotificationFrequency.Daily,
              ),
              OptionButton(
                onPressed: () => setFrequency(NotificationFrequency.Weekly),
                text: "Weekly",
                selected: frequency == NotificationFrequency.Weekly,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
