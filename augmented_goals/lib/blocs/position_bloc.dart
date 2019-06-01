import 'dart:async';

import 'package:augmented_goals/util/map_tools.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';


class PositionBloc{
  Location location = Location();
  Stream<LocationData> get stream => this.position();

  PositionBloc();

  LocationData initial(){
    return null;
}

  LatLng getLatLng(LocationData data){
    return MapTools.getLatLng(data);
  }

  Stream<LocationData> position(){
    print("Location: " + location.toString());
    return location.onLocationChanged();
  }

}