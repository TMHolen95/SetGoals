import 'dart:async';

import 'package:augmented_goals/data_classes/quiz.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:built_collection/src/list.dart';

class NetworkQuizState{

    NetworkQuizState();
}

class NetworkQuizBloc{

  Stream<List<Quiz>> stream;

  NetworkQuizBloc(){
    stream = FirestoreAPI.getQuizzes();
  }

  checkIfTaken(Quiz quiz) {
    BuiltList<String> questionnairesTaken = FirestoreAPI.account.questionnairesTaken;
    if(questionnairesTaken != null){
      return questionnairesTaken.contains(quiz.tag);
    } else{
      return false;
    }

  }

}