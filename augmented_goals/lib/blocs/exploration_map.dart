import 'dart:async';

import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/util/firestore_api.dart';


class MapState {
  List<Challenge> challenges;
  String message;

  MapState();

  printState() {
    print('Instance of MapState: ' +
        '\nchallenges: ' +
        (challenges?.length.toString() ?? 'null') +
        '\nmessage: ' +
        (message ?? '') +
        '\n');
  }
}

class ExplorationMapBloc {
  MapState get initialState {
    print("exp map: init state");
    return MapState();
  }

  final StreamController<MapState> mapStateController =
      StreamController<MapState>();

  Sink get updateMapState => mapStateController.sink;

  Stream<MapState> get mapState => mapStateController.stream;

  void dispose() {
    mapStateController.close();
  }

  update(MapState state) {
    updateMapState.add(state);
  }

  onLoadChallenges(MapState state) async {
    state.challenges = await FirestoreAPI.getChallenges();
    update(state);
  }

  onMessageDisplayed(MapState state) {
    state.message = null;
    update(state);
  }

  bool isCreator(Challenge challenge) {
    return challenge.creatorId == FirestoreAPI.account.accountId;
  }

  removeChallenge(MapState state, Challenge challenge) {
    state.challenges.remove(challenge);
    update(state);
  }


/*  onClusterOpened(MapState state, List<Marker> markersAtPos) {
    // TODO handle opening of clusters
    print("A cluster was tapped");
    update(state);
  }
  List<Marker> getMarkersClustered(MapState state, double zoomLevel) {
    print("Zoom Level: $zoomLevel");
    List<Marker> markers = <Marker>[];
    Map<LatLng, List<Marker>> markerMap = {};
    state.challenges.forEach((challenge) {
      LatLng pos = MapTools.getLatLng(challenge.position);
      // We want the original position here
      Marker marker = createMarker(state, pos, challenge);

      int roundingVal = zoomLevel.floor() - 12;

      markerMap.update(
          pos.round(decimals: roundingVal), (list) => list..add(marker),
          ifAbsent: () => <Marker>[marker]);
    });

    markerMap.forEach((position, markersAtPos) {
      if (markersAtPos.length == 1) {
        markers.add(markersAtPos[0]);
      } else {
        markers.add(createMarker(state, position, null,
            // "Icons" sort of breaks a principle of the bloc pattern, it
            // should not contain flutter specific code as it reduces
            // reuse with platforms such as AngularDart, however I don't
            // plan on using that
            iconData: Icons.whatshot,
            iconSize: 50, onTap: () {
          onClusterOpened(state, markersAtPos);
        }));
      }
    });
    return markers;
  }*/
}
