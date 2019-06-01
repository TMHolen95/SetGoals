import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:augmented_goals/questionnaire_system/question.dart';
import 'package:augmented_goals/questionnaire_system/question_carousel_bloc.dart';
import 'package:augmented_goals/questionnaire_system/question_data.dart';
/// A carousel that handles the logic of likert point questions
///
class QuestionCarousel extends StatefulWidget {
  @required
  final List<QuestionData> questionData;

  @required
  final int likertScalePoints;
  final List<String> labels;

  final bool showQuestionNumbers;
  final bool showTotalQuestions;
  final bool bfi;
  final Function(Map<String, double>) onCategoryResult;

  final Function(List<QuestionData>) onResults;

  const QuestionCarousel({
    Key key,
    this.questionData,
    this.showQuestionNumbers = true,
    this.likertScalePoints,
    this.labels,
    this.bfi = false,
    this.showTotalQuestions = true,
    this.onResults, this.onCategoryResult,
  }) : super(key: key);

  @override
  _QuestionCarouselState createState() => _QuestionCarouselState();
}

class _QuestionCarouselState extends State<QuestionCarousel> {
  QuestionCarouselBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = QuestionCarouselBloc();
  }

  Widget header(QuestionCarouselState state){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            return bloc.onPreviousQuestion(state);
          },
        ),
        Column(
          children: <Widget>[
            Text("Question",
                style: Theme.of(context).textTheme.subhead),
            Visibility(
                visible: widget.showQuestionNumbers,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      bloc.questionInfo(
                          state, widget.showTotalQuestions),
                      style: Theme.of(context).textTheme.caption,
                    ))),
          ],
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            return bloc.onNextQuestion(state, null);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<Object>(
        initialData: bloc.initial(widget.questionData),
        stream: bloc.stream,
        builder: (context, snapshot) {
          QuestionCarouselState state = snapshot.data;
          //print(state.toString());
          //print("Filename: ${widget.questionData[0].fileName}");

          QuestionData activeQuestion = widget.questionData[state.index];
          return SingleChildScrollView(

            child: Column(
              children: <Widget>[
                header(state),
                //Image.network(widget.questionData[0].fileName),
                Question(
                  questionData: activeQuestion,
                  labels: activeQuestion.labels ?? widget.labels,
                  onResult: (result, freeText) {

                    return bloc.onAnswer(state, result, freeText);
                  },
                ),
                Visibility(
                  visible: state.canSubmit,
                  child: FlatButton(
                    child: Text("Save Response"),
                    onPressed: () {
                      try{
                        widget.onCategoryResult(state.calculateResult(widget.likertScalePoints, widget.bfi));
                      } catch(e){
                        print(e);
                      }

                      widget.onResults(state.questions);
                      bloc.onSubmit(state);
                    },
                  ),
                ),
                Visibility(
                  visible: state.showResults,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text("Thank You!"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.bfi ? "This is what is stored in the database:": ""),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(state.showResults && widget.bfi ? prettyJson(state.calculateResult(widget.likertScalePoints, widget.bfi)) : ""),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  String prettyJson(map){
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    return encoder.convert(map);
  }
}
