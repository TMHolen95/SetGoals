import 'dart:async';

import 'package:augmented_goals/blocs/login.dart';

enum EmailLogin { ExistingAccount, NewAccount, PasswordRecovery }

class EmailLoginState {
  EmailLogin internalState = EmailLogin.ExistingAccount;
  String email = "";
  String password = "";
  String confirmPassword = "";
  String name = "";
  String nameError = "";
  String emailError = "";
  String passwordError = "";
  String confirmPasswordError = "";
  String successMessage = "";
  String errorMessage = "";

  EmailLoginState();

  void printMe() {
    print("internalState  : ${internalState.toString()}\n" +
        "email : $email , length: ${email.length}\n" +
        "password : $password , length: ${password.length}\n" +
        "confirmPassword : $confirmPassword , length: ${confirmPassword.length}\n" +
        "errorMessage : $errorMessage , length: ${errorMessage.length}\n" +
        "emailError  : $emailError  , length: ${emailError.length}\n" +
        "passwordError  : $passwordError  , length: ${passwordError.length}\n" +
        "confirmPasswordError  : $confirmPasswordError , length: ${confirmPasswordError.length}\n");
  }
}

class EmailLoginBloc {
  LoginBloc loginBloc;
  EmailLoginState initialState;
  StreamController<EmailLoginState> emailLoginStateController =
      StreamController<EmailLoginState>();

  Sink get updateEmailLoginState => emailLoginStateController.sink;

  Stream<EmailLoginState> get stream => emailLoginStateController.stream;

  EmailLoginBloc(this.loginBloc, this.initialState);

  EmailLoginState initial() {
    this.initialState.printMe();
    return this.initialState ?? EmailLoginState();
  }

  void dispose() {
    emailLoginStateController.close();
  }

  void _update(EmailLoginState state) {
    state.printMe();
    updateEmailLoginState.add(state);
  }

  void updateInternalState(EmailLoginState state, EmailLogin internalState) {
    wipeErrorMessages(state);
    state.internalState = internalState;
    _update(state);
  }

  void updateEmail(EmailLoginState state, String email) {
    state.email = email;
    _update(state);
  }

  void updatePassword(EmailLoginState state, String password) {
    state.password = password;
    _update(state);
  }

  void updateConfirmPassword(EmailLoginState state, String confirmPassword) {
    state.confirmPassword = confirmPassword;
    _update(state);
  }

  void updateName(EmailLoginState state, String name) {
    state.name = name;
    _update(state);
  }

  void updateNameError(EmailLoginState state, String nameError) {
    state.nameError = nameError;
    _update(state);
  }

  void updateSuccessMessage(EmailLoginState state, String successMessage) {
    state.successMessage = successMessage;
    _update(state);
  }

  void updateErrorMessage(EmailLoginState state, String errorMessage) {
    state.errorMessage = errorMessage;
    _update(state);
  }

  void updateEmailError(EmailLoginState state, String emailError) {
    state.emailError = emailError;
  }

  void updatePasswordError(EmailLoginState state, String passwordError) {
    state.passwordError = passwordError;
  }

  void updateConfirmPasswordError(
      EmailLoginState state, String confirmPasswordError) {
    state.confirmPasswordError = confirmPasswordError;
  }

  void loginExistingEmailAccount(EmailLoginState state) {}

  void loginNewEmailAccount(EmailLoginState state) {}

  void handlePasswordRecovery(EmailLoginState state) {}

  Future<bool> confirm(EmailLoginState state, LoginState loginState) async {
    bool res = false;
    switch (state.internalState) {
      case EmailLogin.ExistingAccount:
        if (loginValidates(state)) {
          loginBloc.onExistingAccount(loginState, state.email, state.password);
          res = true;
        }

        break;
      case EmailLogin.NewAccount:
        if (createUserValidates(state)) {
          loginBloc.onNewAccount(
              loginState, state.email, state.password, state.name);
          res = true;
        }

        break;
      case EmailLogin.PasswordRecovery:
        if(recoverAccountValidates(state)){
          loginBloc.onPasswordRecovery(loginState, state.email);
          res = true;
        }
        break;
    }
    _update(state);
    return res;
  }

  bool loginValidates(EmailLoginState state) {
    bool result = true;

    result = validatePassword(state, result);
    result = validateEmail(state, result);

    _update(state);
    return result;
  }

  bool createUserValidates(EmailLoginState state) {
    bool result = true;

    result = validatePasswordsMatch(state, result);
    result = validatePassword(state, result);
    result = validateEmail(state, result);
    result = validateName(state, result);

    _update(state);
    return result;
  }

  bool recoverAccountValidates(EmailLoginState state){
    bool result = true;

    result = validateEmail(state, result);

    _update(state);
    return result;
  }

  bool atExistingAccount(EmailLoginState state) {
    return state.internalState == EmailLogin.ExistingAccount;
  }

  bool atPasswordRecovery(EmailLoginState state) {
    return state.internalState == EmailLogin.PasswordRecovery;
  }

  bool atNewAccount(EmailLoginState state) {
    return state.internalState == EmailLogin.NewAccount;
  }

  String dialogTitle(EmailLoginState state) {
    switch (state.internalState) {
      case EmailLogin.ExistingAccount:
        return "Login with existing account";
      case EmailLogin.NewAccount:
        return "Create new account";
      case EmailLogin.PasswordRecovery:
        return "Recover account";
    }
  }

  String dialogSubmitTitle(EmailLoginState state) {
    switch (state.internalState) {
      case EmailLogin.ExistingAccount:
        return "Login";
      case EmailLogin.NewAccount:
        return "Create Account";
      case EmailLogin.PasswordRecovery:
        return "Reset Password";
    }
  }

  bool validateName(EmailLoginState state, bool currentValidationState) {
    state.nameError = "";
    if (state.name.isEmpty) {
      state.nameError = "Please fill this in!";
      return false;
    }
    return currentValidationState;
  }

  bool validateEmail(EmailLoginState state, bool currentValidationState) {
    state.emailError = "";

    if (!state.email.contains(
        RegExp("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"))) {
      state.emailError = "This is not an email!";
      return false;
    }
    return currentValidationState;
  }

  bool validatePassword(EmailLoginState state, bool currentValidationState) {
    state.passwordError = "";

    if (state.password.isEmpty) {
      state.passwordError = "Please fill this in!";
      return false;
    } else if (state.password.length <= 6) {
      state.passwordError = "Password has to be longer than 6 characters!";
      return false;
    }
    return currentValidationState;
  }

  bool validatePasswordsMatch(EmailLoginState state, bool currentValidationState) {
    state.confirmPasswordError = "";

    if (state.password != state.confirmPassword) {
      state.confirmPasswordError = "Passwords do not match!";
      return false;
    }
    return currentValidationState;
  }

  wipeErrorMessages(EmailLoginState state){
    state.nameError = "";
    state.emailError = "";
    state.passwordError = "";
    state.confirmPasswordError = "";
  }
}
