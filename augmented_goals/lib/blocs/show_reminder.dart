import 'dart:async';

import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ShowReminderBloc{

  Stream<QuerySnapshot> stream;

  ShowReminderBloc(String goalId){
    stream = FirestoreAPI.getReminderStream(goalId);
  }

  void cancel(int id) {
    print("Cancel from bloc");
    FirestoreAPI.cancelReminder(id);
  }



}