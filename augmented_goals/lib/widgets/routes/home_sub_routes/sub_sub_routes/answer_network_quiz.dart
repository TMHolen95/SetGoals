import 'package:augmented_goals/blocs/answer_network_quiz.dart';
import 'package:augmented_goals/data_classes/question.dart';
import 'package:augmented_goals/data_classes/quiz.dart';
import 'package:flutter/material.dart';
import 'package:augmented_goals/questionnaire_system/question_carousel.dart';
import 'package:augmented_goals/questionnaire_system/question_data.dart';

class AnswerQuiz extends StatefulWidget {
  final Quiz quiz;

  AnswerQuiz(this.quiz);

  @override
  _AnswerQuizState createState() => _AnswerQuizState();
}

class _AnswerQuizState extends State<AnswerQuiz> {
  AnswerQuizBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AnswerQuizBloc(widget.quiz.quizId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        leading: CloseButton(),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Question>>(
            stream: bloc.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
              print("Snapshot: hasErrors - ${snapshot.hasError}");
              print("Error: ${snapshot.error.toString()}");
              if (snapshot == null) {
                return CircularProgressIndicator();
              }
              List<Question> data = snapshot.data;
              if (data == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Center(child: Text("No Questions")),
                  ],
                );
              }

              List<QuestionData> questionData = data
                  .map((qst) => QuestionData(
                      quizId: qst.quizId,
                      likertPoints: qst.likertPoints,
                      scoringReversed: qst.scoringReversed,
                      labels: qst.labels.toList(),
                      showNumbers: qst.numbersVisible,
                      category: qst.category,
                      question: qst.question,
                      fileName: qst.fileName,
                      questionId: qst.questionId,
                      isLikert: qst.isLikert,
                      isFreeText: qst.isFreeText))
                  .toList();

              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: QuestionCarousel(
                  showTotalQuestions: true,
                  showQuestionNumbers: true,
                  labels: ["Disagree Strongly", "Agree Strongly"],
                  onResults: (qstData) => bloc.uploadAnswers(qstData),
                  questionData: questionData,
                ),
              ));
            }),
      ),
    );
  }
}
