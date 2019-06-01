import 'package:augmented_goals/blocs/view_logs.dart';
/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DurationSeriesBar extends StatelessWidget {
  final List<charts.Series<DateDuration, DateTime>> seriesList;
  final bool animate;
  final String unit;
  factory DurationSeriesBar(List<DateDuration> data, {animate}){
    Duration highestDur = Duration();
    String unit= "Test";
    data.forEach((dur){
      dur.duration > highestDur ? highestDur = dur.duration : null;
    });
    if(highestDur.inHours > 2){
      unit = "Hours";
    } else if (highestDur.inMinutes > 2){
      unit = "Minutes";
    } else{
      unit = "Seconds";
    }

    List<charts.Series<DateDuration, DateTime>> series = [charts.Series<DateDuration, DateTime>(
      id: 'Measurement',


      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (DateDuration duration, _) => duration.time,
      measureFn: (DateDuration duration, _) {
        if(highestDur.inHours > 2){
          double hours = duration.duration.inHours.toDouble();
          double minutesAsDecimal = duration.duration.inMinutes / 60;
          print("Hours: ${hours + minutesAsDecimal}");
          return hours + minutesAsDecimal;
        } else if (highestDur.inMinutes > 2){
          double minutes = duration.duration.inMinutes.toDouble();
          double secondsAsDecimal = duration.duration.inSeconds / 60;
          print("Hours: ${minutes + secondsAsDecimal}");
          return minutes + secondsAsDecimal;
        } else{
          return duration.duration.inSeconds;
        }

      },
      data: data,)];

    return DurationSeriesBar._(series, animate: animate, unit: unit,);
  }

  DurationSeriesBar._(this.seriesList, {this.animate, this.unit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8,32,8,8),
            child: Text("Duration in $unit", style: Theme.of(context).textTheme.subtitle,),
          ),
          Container(
            width: 300,
            height: 300,
            child: charts.TimeSeriesChart(
              seriesList,
              animate: animate,
              defaultRenderer: new charts.BarRendererConfig<DateTime>(),
              defaultInteractions: false,
              behaviors: [
                new charts.SelectNearest(),
                new charts.DomainHighlighter()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
