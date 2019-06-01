import 'dart:async';
import 'package:augmented_goals/util/authentication.dart';
import 'package:augmented_goals/util/firestore_api.dart';

class LoginState {
  bool inProgress = false;
  String error = "";
  String message = "To login please Consent first";
  bool consent = false;
  bool result;
  bool redirect = false;

  LoginState();

  @override
  String toString() {
    return 'inProgress: ' +
        inProgress.toString() +
        '\n' +
        'error: ' +
        error +
        '\n' +
        'result: ' +
        (result.toString() ?? 'null') +
        '\n' +
        'redirect: ' +
        redirect.toString();
  }
}

class LoginBloc {
  LoginState get initialState => LoginState();

  final StreamController<LoginState> loginStateController =
      StreamController<LoginState>();

  Sink get updateLoginState => loginStateController.sink;

  Stream<LoginState> get mapState => loginStateController.stream;

  void _update(LoginState state) {
    updateLoginState.add(state);
  }

  void dispose() {
    loginStateController.close();
  }

  onLoginInProgress(LoginState state) {
    state.inProgress = true;
    _update(state);
  }

  onFailure(LoginState state) {
    state = initialState;
    state.consent = true;
    state.error = "The login failed, please try agian...";
    _update(state);
  }

  Future onSuccess(LoginState state) async {
    await FirestoreAPI.setAccount();
    await FirestoreAPI.fcmTokenCoherencyCheck();//.catchError((error) => onFailure(state));
    onRedirect(state);
  }

  Future onFacebookLogin(LoginState state) async {
    onLoginInProgress(state);
    state.result = await Auth.loginFacebook();
    state.result ? onSuccess(state) : onFailure(state);
  }

  Future onGoogleLogin(LoginState state) async {
    onLoginInProgress(state);
    state.result = await Auth.loginGoogle();
    state.result ? onSuccess(state) : onFailure(state);
  }

  Future onExistingAccount(LoginState state, String email, String password) async {
    onLoginInProgress(state);
    state.result = await Auth.loginExistingEmailAccount(email, password);
    state.result ? onSuccess(state) : onFailure(state);
  }

  Future onNewAccount(LoginState state, String email, String password, String name) async {
    onLoginInProgress(state);
    state.result = await Auth.loginNewEmailAccount(email, password);
    await FirestoreAPI.createUser(name);
    state.result ? onSuccess(state) : onFailure(state);
  }

  Future onPasswordRecovery(LoginState state, String email) async {
    onLoginInProgress(state);
    state.result = await Auth.handlePasswordRecovery(email);
    state.result ? onSuccess(state) : onFailure(state);
  }

/*  onEmailLogin(LoginState state) async {
    onLoginInProgress(state);
    state.result = await Auth.loginEmail();
    state.result ? onSuccess(state) : onFailure(state);
  }*/

  onRedirect(LoginState state) {
    state.redirect = true;
    _update(state);
  }

  LoginBloc();

  onConsent(LoginState state) {
    state.consent = true;
    _update(state);
  }
}
