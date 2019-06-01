import 'dart:async';

class DurationState{
  Duration duration = Duration();
  String hours = "00";
  String minutes = "00";
  String seconds = "00";

  DurationState();
}

class DurationPickerBloc{

  StreamController<DurationState> durationStateController = StreamController<DurationState>();
  Sink get updateDurationState => durationStateController.sink;
  Stream<DurationState> get durationState => durationStateController.stream;

  DurationPickerBloc();

  DurationState initial(){
    return DurationState();
  }

  void dispose(){
    durationStateController.close();
  }

  void _update(DurationState state){
    print("Duration Updated");
    updateDurationState.add(state);
  }

  String formattedDuration(DurationState state) {
    return "${state.hours}h:${state.minutes??"00"}m:${state.seconds??"00"}s";
  }
  _updateDuration(DurationState state) {
    try{



      int h = (state.hours.isNotEmpty) ? int.parse(state.hours) : 0;
      int m = (state.minutes.isNotEmpty) ? int.parse(state.minutes) : 0;
      int s = (state.seconds.isNotEmpty) ? int.parse(state.seconds) : 0;
      state.duration = Duration(hours: h, minutes: m, seconds: s);
      _update(state);
    } catch (e){
      state.duration = Duration(hours: 0, minutes: 0, seconds: 0);
      _update(state);
    }
  }
  updateHours(DurationState state, String value) {
    if(state.seconds.isEmpty) state.seconds = "";
    if(state.minutes.isEmpty) state.minutes = "";
    state.hours = value;
    _updateDuration(state);
  }

  updateMinutes(DurationState state, String value) {
    if(state.hours.isEmpty) state.hours = "0";
    state.minutes = value;
    _updateDuration(state);
  }

  updateSeconds(DurationState state, String value) {
    if(state.hours.isEmpty) state.hours = "0";
    if(state.minutes.isEmpty) state.minutes = "0";
    state.seconds = value;
    _updateDuration(state);
  }
  String showFormattedDurationIfSet(DurationState state) {
    return (formattedDuration(state) != "00h:00m:00s") ? formattedDuration(state) : "";
  }

}