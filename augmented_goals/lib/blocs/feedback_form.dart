import 'dart:async';

import 'package:augmented_goals/util/firestore_api.dart';

class FeedbackFormState {
  String feedback;
  String feedbackError;
  String submitMessage;
  bool submitted = false;
  FeedbackFormState();
}

class FeedbackFormBloc {
  StreamController<FeedbackFormState> feedbackFormStateController =
      StreamController<FeedbackFormState>();

  Sink get updateFeedbackFormState => feedbackFormStateController.sink;

  Stream<FeedbackFormState> get stream => feedbackFormStateController.stream;

  FeedbackFormBloc();

  FeedbackFormState initial() {
    return FeedbackFormState();
  }

  void dispose() {
    feedbackFormStateController.close();
  }

  void _update(FeedbackFormState state) {
    updateFeedbackFormState.add(state);
  }

  void updateFeedback(FeedbackFormState state, String feedback) {
    state.feedback = feedback;
    _update(state);
  }

  void updateFeedbackError(FeedbackFormState state, String feedbackError) {
    state.feedbackError = feedbackError;
    _update(state);
  }

  void updateSubmitMessage(FeedbackFormState state, String submitMessage){
      state.submitMessage = submitMessage;
      state.submitted = true;
      _update(state);
    }

    void updateSubmitted(FeedbackFormState state){
      state.submitted = true;
      _update(state);
    }

  bool _validated(FeedbackFormState state) {
    if(state.feedback.isEmpty){
      updateFeedbackError(state, "Feedback can not be empty!");
      return false;
    } else {
      updateSubmitMessage(state, "Thank you for your feedback, it is greatly apprechiated :-)");
      return true;
    }

  }

  submit(FeedbackFormState state) async {
    if(_validated(state)){
      await FirestoreAPI.submitFeedback(state.feedback);
      updateFeedback(state, "");
    }
  }
}
