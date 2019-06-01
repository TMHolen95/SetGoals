import 'package:augmented_goals/blocs/view_logs.dart';
import 'package:flutter/material.dart';

class CheckInCalendar extends StatefulWidget {
  final List<DateCheckIn> checkIns;

  const CheckInCalendar(this.checkIns, {Key key}) : super(key: key);

  @override
  _CheckInCalendarState createState() => _CheckInCalendarState();
}

class _CheckInCalendarState extends State<CheckInCalendar> {
  DateTime today = DateTime.now();
  int day;
  int month;
  int year;

  @override
  void initState() {
    super.initState();
    day = today.day;
    month = today.month;
    year = today.year;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Your check-ins", style: Theme.of(context).textTheme.subtitle,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(icon: Icon(Icons.arrow_back), onPressed: () => setState((){
              month -= 1;
              if(month == 0){
                month = 12;
                year -= 1;
              }
            }),),
            Text("$month/$year"),
            IconButton(icon: Icon(Icons.arrow_forward), onPressed: () => setState((){
              month += 1;
              if(month == 13){
                month = 1;
                year += 1;
              }
            }),),

        ],),
        Container(
          margin: EdgeInsets.all(8),
          //color: Colors.black,
          child: GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 7,
            children: createMonthView(),
          ),
        ),
      ],
    );
  }

  List<Widget> createMonthView() {
    List<Widget> days = [];
    for (int i = 1; i <= daysInMonth(); i++) {
      if (isToday(i)) {
        days.add(Day(day: i, checked: false, today: true));
      } else {
        days.add(Day(day: i, checked: false, today: false));
      }
    }

    print(widget.checkIns);
    widget.checkIns?.forEach((checkIn) {
      if (monthContainsCheckIn(checkIn)) {
        int index = checkIn.date.day - 1;
        Day aDay = days[index];

        // Update list to show checked days.
        days[index] = Day(day: aDay.day, checked: true, today: aDay.today);
      }
    });

    return days;
  }

  int daysInMonth() {
    // The next month at day 0 gives the previous months days.
    return DateTime(year, month + 1, 0).day;
  }

  bool monthContainsCheckIn(DateCheckIn checkIn) {
    return checkIn.date.year == year && checkIn.date.month == month;
  }


  /// Compares two [DateTime]s.
  /// Returns true if day, month, and year is the same.
  /// (Ignores hours, ... , microseconds)
  ///
  /// The second [DateTime] is optional, and defaults to [DateTime.now()].
  static bool compareDates(DateTime t1, {DateTime t2}) {
    t2 ?? DateTime.now();
    return t1.day == t2.day && t1.month == t2.month && t1.year == t2.year;
  }

  /// When creating [Day] widgets use this method for checking if the today
  /// parameter should be true [Day(today: true)].
  /// When populating a list through a for-loop.
  bool isToday(int day) {
    return day == today.day && month == today.month && year == today.year;
  }
}

class Day extends StatelessWidget {
  final int day;
  final bool checked;
  final bool today;

  const Day({Key key, this.day, this.checked, this.today}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 30,
      decoration: BoxDecoration(
          border: Border.all(),
          gradient: setGradient()),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 1 ,0 ),
                child: Text(day.toString()),
              )),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1,0,1,1),
              child: Icon(
                checked
                    ? Icons.check_circle_outline
                    : Icons.radio_button_unchecked,
                size: 20,
              ),
            ),
          ),

        ],
      )
      /*Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

        ],
      ),*/
    );
  }

  /// Returns a gradient depending on the tile is checked or if it is today
  LinearGradient setGradient(){
    LinearGradient gradient = checked
        ? LinearGradient(
        colors: [Color(0xffC0ffC0), Color(0xffffffff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight)
        : LinearGradient(
        colors: [Color(0xffe0e0e0), Color(0xffffffff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);


    if(today){
      gradient = LinearGradient(
          colors: [
            Color(checked ? 0xffc0ffc0 : 0xffc0c0ff),
          Color(checked ? 0xffc0c0ff : 0xffffffff)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
    }

    return gradient;
  }

}
