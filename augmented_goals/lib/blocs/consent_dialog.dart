import 'dart:async';

class ConsentDialogState {
  bool rights = false;
  bool participation = false;
  bool dataStorage = false;
  bool dataProcessing = false;
  bool allowSubmit = false;

  ConsentDialogState();
}

class ConsentDialogBloc {
  StreamController<ConsentDialogState> consentDialogStateController =
      StreamController<ConsentDialogState>();

  Sink get updateConsentDialogState => consentDialogStateController.sink;

  Stream<ConsentDialogState> get stream => consentDialogStateController.stream;

  ConsentDialogBloc();

  ConsentDialogState initial() {
    return ConsentDialogState();
  }

  void dispose() {
    consentDialogStateController.close();
  }

  void _update(ConsentDialogState state) {
    updateConsentDialogState.add(state);
  }

  void updateRights(ConsentDialogState state, bool newValue) {
    state.rights = newValue;
    allowSubmit(state);
    _update(state);
  }

  void updateParticipation(ConsentDialogState state, bool newValue) {
    state.participation = newValue;
    allowSubmit(state);
    _update(state);
  }

  void updateDataStorage(ConsentDialogState state, bool newValue) {
    state.dataStorage = newValue;
    allowSubmit(state);
    _update(state);
  }

  void updateDataProcessing(ConsentDialogState state, bool newValue) {
    state.dataProcessing = newValue;
    allowSubmit(state);
    _update(state);
  }

  void allowSubmit(ConsentDialogState state) {
    if (state.rights == true &&
        state.participation == true &&
        state.dataStorage == true &&
        state.dataProcessing == true) {
      state.allowSubmit = true;
    } else {
      state.allowSubmit = false;
    }
  }
}
