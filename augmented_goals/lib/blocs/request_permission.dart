import 'dart:async';

import 'package:location/location.dart';

class RequestLocationState {
  bool hasLocation = false;
  bool done = false;
  bool permissionRequested = false;
  String message = "";
  RequestLocationState();
}

class RequestLocationBloc {

  Location location = Location();

  StreamController<RequestLocationState> requestLocationStateController =
      StreamController<RequestLocationState>();

  Sink get updateRequestLocationState => requestLocationStateController.sink;

  Stream<RequestLocationState> get stream =>
      requestLocationStateController.stream;

  RequestLocationBloc();

  RequestLocationState initial() {
    RequestLocationState state = RequestLocationState();
    hasPermission(state);
    return state;
  }

  void dispose() {
    requestLocationStateController.close();
  }

  void _update(RequestLocationState state) {
    updateRequestLocationState.add(state);
  }

  Future requestPermission(RequestLocationState state) async {
    state.hasLocation = await location.requestPermission();
    state.permissionRequested = true;
    if(!state.hasLocation){
      state.message = "Permission was not granted";
    } else {
      state.message = "Permission obtained";
    }
    _update(state);
  }

  void hasPermission(RequestLocationState state) async{
    state.hasLocation = await location.hasPermission();
    state.done = true;
    _update(state);
  }
}
