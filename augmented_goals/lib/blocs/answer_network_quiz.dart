import 'dart:async';

import 'package:augmented_goals/data_classes/question.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:augmented_goals/questionnaire_system/question_data.dart';

class AnswerQuizState{

    AnswerQuizState();
}

class AnswerQuizBloc{

  Stream<List<Question>> stream;

  AnswerQuizBloc(String quizId){
    stream = FirestoreAPI.getNetworkQuizQuestions(quizId);
  }

  uploadAnswers(List<QuestionData> qstData) {
    FirestoreAPI.uploadResponse(qstData);
  }


}