import 'dart:async';

import 'package:augmented_goals/questionnaire_system/question_data.dart';

class QuestionCarouselState {
  int index = 0;
  String error = "";
  bool canSubmit = false;
  List<QuestionData> questions;
  bool showResults = false;

  QuestionCarouselState(List<QuestionData> questions) {
    this.questions = questions;
  }

  bool hasAnswered() {
    QuestionData qst = this?.questions[index];

    if(qst.isLikert && qst.isFreeText){
      return this?.questions[index].score != null && qst.freeText.isNotEmpty;
    }
    else if(qst.isLikert){
      return this?.questions[index].score != null;
    } else { // is freeText
      return qst.freeText.isNotEmpty;
    }

  }

  bool atEnd() {
    return index == questions.length - 1;
  }

  bool atStart() {
    return index == 0;
  }

  Map<String, double> calculateResult(int likertPoints, bool calculate) {
    if(calculate){
      Map<String, double> catRes = {};
      Map<String, double> catQst = {};

      questions.forEach((data) {
        catRes[data.category] =
            (catRes[data.category] ?? 0) + (data.score + 1);
        catQst[data.category] =
            (catQst[data.category] ?? 0) + 1;
      });

      catRes.forEach((str, i){
        catRes[str] = i / (catQst[str] * likertPoints);
        print("Cat: $str - points: $i - category entries: ${catQst[str]} - LikertValues: $likertPoints");
      });
      print(catRes);
      return catRes;
    } else {
      return null;
    }

  }
}

class QuestionCarouselBloc {
  StreamController<QuestionCarouselState> carouselStateController =
      StreamController<QuestionCarouselState>();

  Sink get updateCarouselState => carouselStateController.sink;

  Stream<QuestionCarouselState> get stream => carouselStateController.stream;

  QuestionCarouselBloc();

  QuestionCarouselState initial(List<QuestionData> questions) {
    return QuestionCarouselState(questions);
  }

  void dispose() {
    carouselStateController.close();
  }

  void _update(QuestionCarouselState state) {
    updateCarouselState.add(state);
    print(state.toString());
  }

  void updateIndex(QuestionCarouselState state, int index) {
    state.index = index;
    _update(state);
  }

  /// Returns a string showing info about the questions.
  ///
  /// Shows either X, X/Y, or Y.
  /// (X is page)
  /// (Y is page count)
  String questionInfo(QuestionCarouselState state, bool showTotalQuestions) {
    String info = (state.index + 1)?.toString() ?? "";
    if (showTotalQuestions) {
      info += "/${state.questions?.length ?? "?"}";
    }
    return info;
  }

  onAnswer(QuestionCarouselState state, int result, String freeText) {
    print("onAnswer - $result");
    QuestionData questionData = state.questions[state.index];
    questionData.setScore(result);
    questionData.printMe();

    String errMsg = "Tap next again if you don't want to provide an answer.";

    if(questionData.isFreeText && freeText.isEmpty){
      state.error = errMsg;
    }
    else if (!state.atEnd()) {
      state.index++;
    } else if (state.atEnd()) {
      state.canSubmit = true;
    }
    _update(state);
  }

  onPreviousQuestion(QuestionCarouselState state) {
    print("onPreviousQuestion");
    if (!state.atStart()) {
      state.error = "";
      state.index -= 1;
    } else if (state.atStart()) {
      state.error = "You are at the first question!";
    }
    _update(state);
  }

  onNextQuestion(QuestionCarouselState state, int result) {
/*    if(result != null){
      state.questions[state.index].setScore(result);
    }*/

    print("onNextQuestion");
    if (!state.hasAnswered()) {
      print("Not answered! ${state.questions[state.index].score}");
      state.error = "Please answer before proceeding!";
    } else if (!state.atEnd()) {
      print("Proceeding to next question!");
      state.error = "";
      state.index += 1;
    } else if (state.atEnd()) {
      print("At end please submit!!");
      state.error = "Please Submit";
      state.canSubmit = true;
    }
    _update(state);
  }

  void onSubmit(QuestionCarouselState state) {
    state.showResults = true;
    _update(state);
  }
}
