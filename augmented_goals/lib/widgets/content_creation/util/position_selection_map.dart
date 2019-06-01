import 'package:augmented_goals/blocs/position_bloc.dart';
import 'package:augmented_goals/util/map_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class PositionSelectionMap extends StatefulWidget {
  const PositionSelectionMap({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<PositionSelectionMap>{
  LatLng _goalPosition = MapTools.unsetPosition();
  PositionBloc bloc = PositionBloc();

  Widget map(LatLng position){
    LatLng neBound = Haversine().offset(position, 3000, 45.0);
    LatLng swBound = Haversine().offset(position, 3000, -135);

    return Center(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlutterMap(
        options:
        MapOptions(
            center: position,
            zoom: 16.0,
            minZoom: 15.0,
            maxZoom: 19.0,
            nePanBoundary: neBound,
            swPanBoundary: swBound,
            onTap: _selectPosition
        ),
        layers: [
          MapTools.mapTileProvider(),
          MarkerLayerOptions(
            markers: [
              Marker(point: _goalPosition, builder: (context) => Icon(Icons.flag)),
              MapTools.positionMarker(position),
            ],
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget posMap = StreamBuilder(
        initialData: bloc.initial(),
        stream: bloc.stream,
        builder: (context, AsyncSnapshot<LocationData> snapshot) {
          print("snapshot: " + snapshot.toString());
          LocationData data = snapshot.data;
          /*print("Lat: ${data.latitude}, Long${data.longitude}");*/
          if (data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Awaiting position..."),
                  ),
                ],
              ),
            );
          }

          LatLng myPosition = bloc.getLatLng(data);
          print(myPosition);

          return map(myPosition);
        });


    return Scaffold(
      appBar: AppBar(
        title: Text("Select Position"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: (){
                if(_goalPosition != MapTools.unsetPosition()){
                  Navigator.pop(context, MapTools.getGeoPoint(_goalPosition));
                } else {
                  Navigator.pop(context);
                }
              }
          )
        ],
      ),
      body: posMap
    );
  }

  void _selectPosition(LatLng latlng) {
    print("Map tapped: " + latlng.toString());
    setState(() {
      _goalPosition = latlng;
    });
  }


}

