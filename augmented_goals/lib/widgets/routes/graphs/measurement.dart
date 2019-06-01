import 'package:augmented_goals/blocs/view_logs.dart';
/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TimeSeriesBar extends StatelessWidget {
  final List<charts.Series<DateMeasurement, DateTime>> seriesList;
  final bool animate;
  final String title;

  factory TimeSeriesBar(List<DateMeasurement> data, {animate, String title = "title"}){
    List<charts.Series<DateMeasurement, DateTime>> series = [charts.Series<DateMeasurement, DateTime>(
      id: 'Measurement',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (DateMeasurement measurement, _) => measurement.time,
      measureFn: (DateMeasurement measurement, _) => measurement.number,
      data: data,)];

    return TimeSeriesBar._(series, animate: animate, title: title);
  }

  TimeSeriesBar._(this.seriesList, {this.animate, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8,32,8,8),
            child: Text(title, style: Theme.of(context).textTheme.subtitle,),
          ),
          Container(
            width: 300,
            height: 300,
            child: charts.TimeSeriesChart(
              seriesList,
              animate: animate,
              defaultRenderer: new charts.BarRendererConfig<DateTime>(),
              defaultInteractions: false,
              /*primaryMeasureAxis: charts.NumericAxisSpec(
                  showAxisLine: true,
                  viewport: charts.NumericExtents(0, 10)
              ),*/
              /*secondaryMeasureAxis: charts.NumericAxisSpec(
                *//*tickFormatterSpec: ,*//*
                showAxisLine: true,
                viewport: charts.NumericExtents(0, 10)
              ),*/
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
