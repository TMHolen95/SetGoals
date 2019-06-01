import 'package:augmented_goals/util/firestore_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  TextEditingController questionnaireController;
  TextEditingController questionNumberController;

  @override
  void initState() {
    super.initState();
    questionnaireController = TextEditingController(text: "");
    questionNumberController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text("Add Question"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]"))],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Questionnaire Name"
                ),
                controller: questionnaireController,
              ),
            ),
            // The starting point to add questions
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]"))],
                maxLength: 2,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Questions to generate"
                ),
                controller: questionNumberController,
              ),
            ),
            // Number of questions to add
            RaisedButton(
              // Submit
              child: Text("Submit"),
              onPressed: () async {
                await FirestoreAPI.addQuestions(
                    questionnaireController.text,
                    int.parse(questionNumberController.text));
              },
            )
          ],
        ),
      ),
    );
  }
}
