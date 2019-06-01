import 'package:augmented_goals/blocs/position_bloc.dart';
import 'package:augmented_goals/blocs/exploration_map.dart';
import 'package:augmented_goals/blocs/request_permission.dart';
import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/widgets/content_creation/create_challenge.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/util/app_bar_actions.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/util/navigation_bar.dart';
import 'package:augmented_goals/widgets/util/category_icon.dart';
import 'package:augmented_goals/widgets/util/logo_image.dart';
import 'package:augmented_goals/widgets/util/quick_view_challenge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:augmented_goals/util/map_tools.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class ExplorationMap extends StatefulWidget {
  const ExplorationMap({Key key}) : super(key: key);

  @override
  _ExplorationMapState createState() => _ExplorationMapState();
}

class _ExplorationMapState extends State<ExplorationMap>
    implements AppBarActions {
  Key scaffoldKey = Key("MapScaffold");
  ExplorationMapBloc mapBloc = ExplorationMapBloc();
  PositionBloc posBloc = PositionBloc();
  RequestLocationBloc reqBloc = RequestLocationBloc();
  LatLng lastPosition;

  MapController mapController;
  MapState lastState;

  void initState() {
    super.initState();
    mapController = new MapController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO query within a bounding box restricting the map to display nearby goals.
    // TODO group close goals when they're displayed in map
    print("Exploration map is building");
    Widget map(LatLng position) {
      return StreamBuilder(
          stream: mapBloc.mapState,
          initialData: mapBloc.initialState,
          builder: (context, snapshot) {
            print("Exploration map is building stream");
            MapState state = snapshot.data;
            state.printState();
            lastState = state;
            if (state.challenges == null) {
              mapBloc.onLoadChallenges(state);
              return CircularProgressIndicator(
                value: 0.0,
              );
            }

            if (state.message != null) {
              Future.delayed(Duration(milliseconds: 100)).then((val) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(key: scaffoldKey, content: Text(state.message)));
              });
            }

            final FlutterMap map = FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  center: position,
                  zoom: 16.0,
                  minZoom: 15.0,
                  maxZoom: 19.0,
                  interactive: false),
              layers: <LayerOptions>[],
            );

            List<Marker> markers = getMarkers(state, context);
            markers.add(MapTools.positionMarker(position));

            map.layers
              ..add(MapTools.mapTileProvider())
              ..add(MarkerLayerOptions(markers: markers));

            return map;
          });
    }

    final Widget posStream = StreamBuilder(
        initialData: posBloc.initial(),
        stream: posBloc.stream,
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

          LatLng myPosition = posBloc.getLatLng(data);
          print(myPosition);
          lastPosition = myPosition;
          return map(myPosition);
        });

    final Widget requestPosStream = StreamBuilder(
      initialData: reqBloc.initial(),
      stream: reqBloc.stream,
      builder: (context, AsyncSnapshot<RequestLocationState> snapshot) {
        RequestLocationState state = snapshot.data;
        if (!state.done) {
          return Center(child: CircularProgressIndicator());
        } else if (state.hasLocation) {
          return posStream;
        } else if (!state.hasLocation) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                  child: Text("To display nearby challenges the application requires your location.", textAlign: TextAlign.center,),
                ),
                RaisedButton(
                    onPressed: () => reqBloc.requestPermission(state),
                    child: Text("Enable Location"),
                ),
                Visibility(
                  visible: state.message.isNotEmpty,
                  child: Text(state.message),
                )
              ],
            ),
          );
        }
      },
    );

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: HomeImage(Icons.map),
          title: Text("Nearby Challenges"),
          actions: appBarActions(),
        ),
        bottomNavigationBar: NavigationBar(),
        body: requestPosStream);
  }

  Marker createMarker(MapState state, BuildContext context, LatLng position,
      Challenge challenge,
      {VoidCallback onTap, IconData iconData, Color color, double iconSize, Function(Challenge) onDelete}) {

    VoidCallback defaultOnTap = () {
      showChallengeDialog(context, challenge, onDelete);
    };

    return Marker(
        point: position,
        builder: (context) => GestureDetector(
            onTap: onTap ?? defaultOnTap,
            child: iconData != null
                ? Icon(iconData, size: iconSize ?? 30, color: color,)
                : CategoryIcon(
                    goalCategory: challenge.category,
                    color: color,
                  )));
  }

  List<Marker> getMarkers(MapState state, BuildContext context) {
    List<Marker> markers = <Marker>[];
    state.challenges.forEach((challenge) {
      LatLng pos = MapTools.getLatLng(challenge.position);
      // We want the original position here

      Marker marker;
      if(mapBloc.isCreator(challenge)){
        marker = createMarker(state, context, pos, challenge, color: Colors.deepPurple, onDelete: (challenge) => mapBloc.removeChallenge(state, challenge));
      } else {
        marker = createMarker(state, context, pos, challenge);
      }
      markers.add(marker);
    });
    return markers;
  }

  showChallengeDialog(BuildContext context, Challenge challenge, Function(Challenge) onDelete) {
    showDialog(
        context: context,
        builder: (buildContext) => QuickViewChallenge(
              challenge: challenge,
              onDelete: onDelete
            ));
  }

  @override
  List<Widget> appBarActions() {
    List<Widget> actions = <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateChallengeForm()),
            ).then((result) =>
                mapBloc.onLoadChallenges(lastState)); // Refresh goals
          })
    ];

    AppBarActions.appendDefaultActions(actions, context);
    return actions;
  }

  @override
  void dispose() {
    super.dispose();
    mapBloc.dispose();
    reqBloc.dispose();
  }
}
