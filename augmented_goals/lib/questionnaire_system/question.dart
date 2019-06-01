library questionnaire;

import 'package:augmented_goals/util/firestore_api.dart';
import 'package:augmented_goals/widgets/util/firestore_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:augmented_goals/questionnaire_system/likert_scale.dart';
import 'package:augmented_goals/questionnaire_system/question_data.dart';

class Question extends StatefulWidget {
  @required
  final QuestionData questionData;

  final List<String> labels;
  final Function(int, String) onResult;

  const Question({
    Key key,
    this.labels,
    this.questionData,
    this.onResult,
  }) : super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

  Widget hasImageAttached() {
    if (widget.questionData.fileName != null &&
        widget.questionData.fileName.isNotEmpty) {
      return FutureBuilder<StorageReference>(
          future: FirestoreAPI.getQuestionnaireStorageReference(
              widget.questionData.fileName),
          builder: (context, snapshot) {
            print("Connection state: ${snapshot.connectionState.toString()}");
            if (snapshot.hasError) {
              return Text("Image could not be loaded");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                    width: 500,
                    height: 500,
                    child: FirestoreImage(
                        key: UniqueKey(), reference: snapshot.data)),
              );
            }
          });
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("Labels: ${widget.questionData.labels ?? widget.labels}");
    //widget.questionData.printMe();
    return Card(
      child: Column(
        children: <Widget>[
          hasImageAttached(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.questionData.question,
                style: Theme.of(context).textTheme.subhead),
          ),
          Visibility(
            visible: widget.questionData.isLikert,
            child: LikertScale(
              animate: !widget.questionData.isFreeText,
              showNumbers: widget.questionData.showNumbers,
              autoProgress: //widget.questionData.hasNoAnswer(),
                  (!widget.questionData.isFreeText)
                      ? widget.questionData.hasNoAnswer()
                      : false,
              preSelectedValue: widget.questionData.likertValue(),
              radioButtons: widget.questionData.likertPoints,
              labels: widget.questionData.labels ?? widget.labels,
              onChange: (result) {
                print("Change in likert scale");
                setState(() {
                  widget.questionData.setScore(result);
                });

                return widget.onResult(result, widget.questionData.freeText);
              },
            ),
          ),
          Visibility(
            visible: widget.questionData.isFreeText,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Answer in freetext",
                  hintText: "Please provide an answer to continue",
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: widget.questionData.freeText),
                maxLines: 4,
                onChanged: (changed) => widget.questionData.freeText = changed,
                onEditingComplete: () {
                  return widget.onResult(widget.questionData.score, widget.questionData.freeText);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}


