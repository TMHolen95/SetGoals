import 'package:augmented_goals/widgets/util/option_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class WeekdayPicker extends StatefulWidget {
  final Function(Day) onDaySelected;

  const WeekdayPicker({Key key, this.onDaySelected}) : super(key: key);

  @override
  _WeekdayPickerState createState() => _WeekdayPickerState();
}

class _WeekdayPickerState extends State<WeekdayPicker> {
  Day day;

  bool isSelected(Day day) => this.day == day;

  void setDay(Day day) {
    widget.onDaySelected(day);
    setState(() => this.day = day);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Reminder Day", ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              OptionButton(onPressed: () => setState(() => setDay(Day.Monday)),
                text: "Mon",
                selected: isSelected(Day.Monday),),
              OptionButton(onPressed: () => setState(() => setDay(Day.Tuesday)),
                text: "Tue",
                selected: isSelected(Day.Tuesday),),
              OptionButton(onPressed: () => setState(() => setDay(Day.Wednesday)),
                text: "Wed",
                selected: isSelected(Day.Wednesday),),
              OptionButton(onPressed: () => setState(() => setDay(Day.Thursday)),
                text: "Thu",
                selected: isSelected(Day.Thursday),),
              OptionButton(onPressed: () => setState(() => setDay(Day.Friday)),
                text: "Fri",
                selected: isSelected(Day.Friday),),
              OptionButton(onPressed: () => setState(() => setDay(Day.Saturday)),
                text: "Sat",
                selected: isSelected(Day.Saturday),),
              OptionButton(onPressed: () => setState(() => setDay(Day.Sunday)),
                text: "Sun",
                selected: isSelected(Day.Sunday),),
            ],
          ),
        ),
      ],
    );
  }
}

