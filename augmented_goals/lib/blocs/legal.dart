import 'dart:async';

import 'package:augmented_goals/util/firestore_api.dart';

class LegalState {
  String name = "";
  String deletionMessage = "";

  LegalState();
}

class LegalBloc {
  StreamController<LegalState> legalStateController =
      StreamController<LegalState>();

  Sink get updateLegalState => legalStateController.sink;

  Stream<LegalState> get legalState => legalStateController.stream;

  LegalBloc();

  LegalState initial() {
    return LegalState();
  }

  void dispose() {
    legalStateController.close();
  }

  void _update(LegalState state) {
    updateLegalState.add(state);
  }

  updateName(LegalState state, String text) {
    state.name = text;
    _update(state);
  }

  updateDeletionMessage(LegalState state, String text) {
    state.deletionMessage = text;
    _update(state);
  }

  void deleteAccount(LegalState state) {
    print("Initiating deletion of user.");

      updateDeletionMessage(state,
          "Your account is being deleted, you will now be signed out permanently in a few seconds.\n\nHowever, you are welcome to create a new account in the future, if you change your mind.");
      Future.delayed(Duration(seconds: 3)).then((val) async {
        bool success = await FirestoreAPI.deleteAccount();
        if(!success){
          updateDeletionMessage(state,
              "Your login credentials were too old for this operation! Please sign-out and back in, then try again, it should succeed then, apologies for the inconvenience.");
        }
      });
  }

  Future changeName(LegalState state) {
    print("Initiating name change.");
    return FirestoreAPI.changeName(state.name);
  }

  Future downloadData(LegalState state) {
    print("Initiating data download.");
    return FirestoreAPI.generateDownload();
  }
}
