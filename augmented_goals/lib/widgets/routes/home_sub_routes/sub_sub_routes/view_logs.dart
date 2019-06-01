import 'package:augmented_goals/blocs/view_logs.dart';
import 'package:augmented_goals/data_classes/enabled_log_options.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/data_classes/log_entry.dart';
import 'package:augmented_goals/widgets/routes/graphs/check_in.dart';
import 'package:augmented_goals/widgets/routes/graphs/duration.dart';
import 'package:augmented_goals/widgets/routes/graphs/measurement.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewLogs extends StatefulWidget {
  final Goal goal;

  const ViewLogs({Key key, this.goal}) : super(key: key);

  @override
  _ViewLogsState createState() => _ViewLogsState();
}

class _ViewLogsState extends State<ViewLogs> {
  ViewLogEntryBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ViewLogEntryBloc(widget.goal);
  }

  @override
  Widget build(BuildContext context) {
    //EnabledLogOptions options = widget.goal.logOptions;
    Widget body = FutureBuilder(
        future: bloc.populateLogState(),
        builder: (context, AsyncSnapshot<List<LogEntry>> snapshot) {
          if (snapshot == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Loading..."),
                  ),
                ],
              ),
            );
          }

          List<Widget> wid = [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Goal: " + widget.goal.title,
                style: Theme.of(context).textTheme.headline,
              ),
            )
          ];

          EnabledLogOptions opt = widget.goal.logOptions;
          if (opt == null) {
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Try logging some data first, then come back!"),
                ),
              ],
            ));
          }
          if (opt.dailyCheckIn) wid.add(CheckInCalendar(bloc.dateCheckIn));
          if (opt.measurement) {
            String measurementUnit = snapshot.data.length >= 1
                ? snapshot.data[0].measurementUnit
                : "unit";
            wid.add(TimeSeriesBar(
              bloc.dateMeasurement,
              title: "Measurement: $measurementUnit",
            ));
          }
          if (opt.performance)
            wid.add(TimeSeriesBar(
              bloc.dateRating,
              title: "Rating: 1-10",
            ));
          if (opt.duration) wid.add(DurationSeriesBar(bloc.dateDuration));
          if (opt.reflectiveNotes) wid.add(ReflectionNotes(bloc.dateNotes));

          return SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: wid),
          );
        });

    return Scaffold(
      appBar: AppBar(leading: CloseButton(), title: Text("View Logs")),
      body: body,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ReflectionNotes extends StatelessWidget {
  final List<DateNotes> notes;

  const ReflectionNotes(
    this.notes, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
          child: Text(
            "Notes",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        ListView(
            primary: false,
            shrinkWrap: true,
            children: notes.map((note) {
              var formatter = new DateFormat('dd.MM.yyyy  HH:mm ');
              String formatted = formatter.format(note.time);

              return ListTile(
                title: Text(note.notes),
                subtitle: Text(formatted),
              );
            }).toList()),
      ],
    );
  }
}

class RatingTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Rating");
  }
}

class DurationTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Duration");
  }
}
// https://google.github.io/charts/flutter/example/time_series_charts/with_bar_renderer
