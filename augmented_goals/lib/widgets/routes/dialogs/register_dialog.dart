import 'package:augmented_goals/blocs/login.dart';
import 'package:augmented_goals/blocs/register_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailLoginDialog extends StatefulWidget {
  final LoginBloc loginBloc;
  final LoginState lastLoginState;
  final EmailLoginState savedState;
  final Function(EmailLoginState) onNewState;
  const EmailLoginDialog({Key key, this.loginBloc, this.lastLoginState, this.savedState, this.onNewState}) : super(key: key);

  @override
  _EmailLoginDialogState createState() => _EmailLoginDialogState();
}

class _EmailLoginDialogState extends State<EmailLoginDialog> {
  EmailLoginBloc bloc;
  TextEditingController email;
  TextEditingController name;
  TextEditingController password;
  TextEditingController confirmPassword;


  @override
  void initState() {
    super.initState();
    print("\n\nRestored State: ");
    widget.savedState.printMe();
    bloc = EmailLoginBloc(widget.loginBloc, widget.savedState);
    email = TextEditingController(text: widget.savedState.email);
    name = TextEditingController(text: widget.savedState.name);
    password = TextEditingController(text: widget.savedState.password);
    confirmPassword = TextEditingController(text: widget.savedState.confirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StreamBuilder<EmailLoginState>(
          initialData: bloc.initial(),
          stream: bloc.stream,
          builder: (context, snapshot) {

            EmailLoginState state = snapshot.data;
            widget.onNewState(state);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      bloc.dialogTitle(state),
                      style: Theme.of(context).textTheme.headline,
                      textAlign: TextAlign.center,
                    ),


                    TextField(
                      controller: email,
                      onChanged: (email) => bloc.updateEmail(state, email),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email", errorText: state.emailError),
                    ),

                    Visibility(
                      visible: bloc.atNewAccount(state),
                      child: TextField(
                        controller: name,
                        onChanged: (name) => bloc.updateName(state, name),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Name", errorText: state.nameError),
                      ),
                    ),

                    Visibility(
                      visible: !bloc.atPasswordRecovery(state),
                      child: TextField(
                        controller: password,
                        onChanged: (password) =>
                            bloc.updatePassword(state, password),
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password", errorText: state.passwordError),
                      ),
                    ),
                    Visibility(
                      visible: bloc.atNewAccount(state),
                      child: TextField(
                        controller: confirmPassword,
                        onChanged: (password) =>
                            bloc.updateConfirmPassword(state, password),
                        obscureText: true,
                        decoration:
                            InputDecoration(labelText: "Confirm Password", errorText: state.confirmPasswordError),

                      ),
                    ),


                    Visibility(
                        visible: !bloc.atExistingAccount(state),
                        child: FlatButton(
                            onPressed: () => bloc.updateInternalState(
                                state, EmailLogin.ExistingAccount),
                            child: Text("Login With Existing Account"))),
                    Visibility(
                        visible: !bloc.atNewAccount(state),
                        child: FlatButton(
                            onPressed: () => bloc.updateInternalState(
                                state, EmailLogin.NewAccount),
                            child: Text("Create New Account"))),
                    Visibility(
                        visible: bloc.atExistingAccount(state),
                        child: FlatButton(
                            onPressed: () => bloc.updateInternalState(
                                state, EmailLogin.PasswordRecovery),
                            child: Text("Recover Account"))),

                    Visibility(
                        visible: state.successMessage.isNotEmpty,
                        child: Text(state.successMessage)),
                    Visibility(
                        visible: state.errorMessage.isNotEmpty,
                        child: Text(state.errorMessage)),

                    RaisedButton(
                      onPressed: () async {
                          bool res = await bloc.confirm(state, widget.lastLoginState);
                          if(res){
                            Navigator.pop(context);
                          }
                      },
                      child: Text(bloc.dialogSubmitTitle(state)),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
