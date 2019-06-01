import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

abstract class MapTools {

  static Stream<LocationData> position(){
    Location location = new Location();
    print("Location: " + location.toString());
    location.hasPermission().then((val)=> print("Has permisson: ${val}"));
    return location.onLocationChanged();
  }

  static Future<LatLng> updatePositionProprietary() async {
    LocationData currentLocation;
    Location location = new Location();
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      currentLocation = await location.getLocation();
    } on PlatformException {
      currentLocation = null;
    }

    return MapTools.getLatLng(currentLocation);
  }

  static LatLng updatePosition(LatLng oldPosition) {
    updatePositionProprietary()
        .then((result) {
      return result;
    });
    return oldPosition;
  }

  static Future<LatLng> updatePositionInitial() async {
    return await updatePositionProprietary();
  }

  /// Helpful for the FlutterMap widget
  /// aPositionType any class with longitude and latitude fields such as
  /// Position, GeoPoint, or ironically LatLong.
  static LatLng getLatLng(aPositionType) {
    try {
      return LatLng(aPositionType.latitude, aPositionType.longitude);
    } catch (e) {
      if (aPositionType == null) {
        throw UnsupportedError(
            "MapTools.getLatLng() requires a non-null class with latitude and longitude fields");
      } else {
        throw UnsupportedError(
            "MapTools.getLatLng() only supports classes with latitude and longitude fields");
      }
    }
  }

  /// Helpful for obtaining the right format for location data for Firestore.
  /// aPositionType any class with longitude and latitude fields such as
  /// Position, GeoPoint, or ironically LatLong.
  static GeoPoint getGeoPoint(aPositionType) {
    try {
      return GeoPoint(aPositionType.latitude, aPositionType.longitude);
    } catch (e) {
      if (aPositionType == null) {
        throw UnsupportedError(
            "MapTools.getGeoPoint() requires a non-null LatLng or Location");
      } else {
        throw UnsupportedError(
            "MapTools.getGeoPoint() only supports classes with latitude and longitude fields");
      }
    }
  }

  static LatLng unsetPosition() {
    return LatLng(0.0, 0.0);
  }

  static Marker positionMarker(position) {
    position = getLatLng(position);

    return Marker(
      width: 80.0,
      height: 80.0,
      point: position,
      builder: (ctx) => Container(
            child: Icon(Icons.person, color: Colors.blueAccent,),
          ),
    );
  }

  static MapOptions mapOptions(userPosition, event) {
    userPosition = getLatLng(userPosition);

    return MapOptions(center: userPosition, zoom: 16.0, onTap: event);
  }

  static TileLayerOptions mapTileProvider() {
    return TileLayerOptions(
      urlTemplate:
          //"https://tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey=cc344d6b840944939ca9a46a8c6486f7",
          "https://maps.tilehosting.com/styles/basic/{z}/{x}/{y}.png?key=28WOfobqrAwPx8PmDj6V",
      additionalOptions: {
        //'accessToken': 'cc344d6b840944939ca9a46a8c6486f7',
        //'id': 'thunderforest.landscape',
        'accessToken': '28WOfobqrAwPx8PmDj6V',
        'id': 'maptiler.basic',
      },
    );
  }
}
