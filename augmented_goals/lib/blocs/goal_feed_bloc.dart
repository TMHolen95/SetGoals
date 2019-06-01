import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'dart:async';

enum Filter { active, newGoal, completed, failure, all}

class FilterState{
    Filter filter;
    FilterState();
}

class FilterHandlerBloc{

  Stream<QuerySnapshot> goalStream(Filter state) => GoalFeedStreamHandler.filteredStream(state);

  FilterHandlerBloc();

  FilterState initial(){
    return FilterState();
  }

  deleteGoal(String documentId) {
    FirestoreAPI.deleteGoal(documentId);
  }
}

abstract class GoalFeedStreamHandler {
  static Stream<QuerySnapshot> filteredStream(Filter filter) {
    switch (filter) {
      case Filter.active:
        return filterOnActive();
        break;
      case Filter.newGoal:
        return filterOnNew();
        break;
      case Filter.completed:
        return filterOnCompleted();
        break;
      case Filter.failure:
        return filterOnFailure();
        break;
      case Filter.all:
        return FirestoreAPI.getUserGoalStream();
        break;
      default:
        return FirestoreAPI.getUserGoalStream();
    }
  }

  static Stream<QuerySnapshot> filterOnActive() {
    return FirestoreAPI.collectionGoalOfCurrentUser().where("active", isEqualTo: true).snapshots();

  }

  static Stream<QuerySnapshot> filterOnFailure() {
    return FirestoreAPI.collectionGoalOfCurrentUser().where("state", isEqualTo: "failure").snapshots();

  }

  static Stream<QuerySnapshot> filterOnCompleted() {
    return FirestoreAPI.collectionGoalOfCurrentUser().where("state", isEqualTo: "completed").snapshots();

  }

  static Stream<QuerySnapshot> filterOnNew() {
    return FirestoreAPI.collectionGoalOfCurrentUser().where("state", isEqualTo: "newGoal").where("active", isEqualTo:  false).snapshots();

  }
}
