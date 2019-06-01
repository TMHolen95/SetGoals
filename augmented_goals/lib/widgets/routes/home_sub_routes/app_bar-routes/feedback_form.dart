import 'package:augmented_goals/blocs/feedback_form.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  FeedbackFormBloc bloc;
  FeedbackFormState initialState;
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    bloc = FeedbackFormBloc();
    initialState = bloc.initial();
    controller = TextEditingController(text: initialState.feedback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text("Feedback Form"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<FeedbackFormState>(
            stream: bloc.stream,
            initialData: initialState,
            builder: (context, snapshot) {
              FeedbackFormState state = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: controller,
                      onChanged: (feedback) =>
                          bloc.updateFeedback(state, feedback),
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: "Feedback", errorText: state.feedbackError),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Submit Feedback"),
                        onPressed: () {
                          controller.clear();
                          return bloc.submit(state);
                        },
                      ),
                    ),
                    Visibility(
                      visible: state.submitted,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconTextTile(iconData: Icons.check, text: "Thank you for your feedback!"),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Do you think something can be improved in the application, or is there something you like or dislike, please submit some feedback. All feedback is greatly appreciated."),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
