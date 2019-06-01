import 'package:augmented_goals/blocs/login.dart';
import 'package:augmented_goals/blocs/register_dialog.dart';
import 'package:augmented_goals/util/app_strings.dart';
import 'package:augmented_goals/widgets/routes/dialogs/consent_dialog.dart';
import 'package:augmented_goals/widgets/routes/dialogs/register_dialog.dart';
import 'package:augmented_goals/widgets/util/logo_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = LoginBloc();
  LoginState lastState;
  EmailLoginState emailLoginState;

  @override
  void initState() {
    super.initState();
    emailLoginState = EmailLoginState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget buildBody = StreamBuilder(
        stream: bloc.mapState,
        initialData: bloc.initialState,
        builder: (context, snapshot) {
          lastState = snapshot.data;
          print(lastState.toString());
          if (lastState.redirect) {
            Future.delayed(Duration(milliseconds: 50)).then((_) {
              Navigator.pushReplacementNamed(context, '/home');
            });
          }

          return lastState.inProgress == true
              ? Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),)
              : Column(
                  children: <Widget>[
                    WelcomeMessage(),
/*                    LoginButton(
                      enabled: lastState.consent,
                      key: Key("facebookLogin"),
                      text: "Login with Facebook",
                      onPressed: () => bloc.onFacebookLogin(lastState),
                    ),*/
                    LoginButton(
                      enabled: lastState.consent,
                      key: Key("facebookLogin"),
                      child: FacebookSignInButton(
                        onPressed: () => bloc.onFacebookLogin(lastState),
                      ),
                    ),
                    LoginButton(
                      enabled: lastState.consent,
                      key: Key("googleLogin"),
                      child: GoogleSignInButton(
                        onPressed: () => bloc.onGoogleLogin(lastState),
                      ),
                    ),
                    LoginButton(
                      enabled: lastState.consent,
                      child: GestureDetector(
                        onTap: () => showEmailLoginDialog(context),
                        child: Card(
                          color: Colors.cyanAccent,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(Icons.mail, color: Colors.black, size: 30,),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Sign in with email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                ),
                              )
                            ],),
                        ),
                      ),

                    ),
                    ConsentButton(
                      onConsent: () => bloc.onConsent(lastState),
                      visible: !lastState.consent,
                    ),
                    Visibility(
                      visible: !lastState.consent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("You need to consent to a information letter on how we process data before you can sign-in/register.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.caption,),
                      ),
                    ),
                    ConsentForm(),
                    ErrorMessage(
                      text: lastState.error,
                    )
                  ],
                );
        });

    return Scaffold(
        appBar: AppBar(
          leading: HomeImage(Icons.vpn_key),
          title: Text("Login"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildBody,
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showEmailLoginDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return EmailLoginDialog(
            loginBloc: bloc,
            lastLoginState: lastState,
            savedState: emailLoginState,
            onNewState: (newEmailLoginState) =>
                emailLoginState = newEmailLoginState,
          );
        });
  }
}

class ErrorMessage extends StatelessWidget {
  final String text;

  const ErrorMessage({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }
}

class WelcomeMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Welcome to ${AppStrings.name}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline),
    );
  }
}

class ConsentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("By signing in you agree to the", textAlign: TextAlign.center, style: Theme.of(context).textTheme.caption,),
            GestureDetector(
                onTap: () async {
                  const url =
                      'https://sites.google.com/view/augmented-goals-privacy-policy/home';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text(" Privacy Policy",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 12), textAlign: TextAlign.center,))
          ],
        ));
  }
}

class ConsentButton extends StatelessWidget {
  final text;
  final bool visible;
  final VoidCallback onConsent;

  const ConsentButton(
      {Key key, this.text = "Open Consent Dialog", this.onConsent, this.visible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("You are close to start working on your goals.\nTap the button below to get started.",
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
            ),
            FlatButton(
              color: Colors.lightBlueAccent,
              textColor: Colors.deepPurple,
              child: Text(
                text,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
              onPressed: () => showDialog(
                  builder: (BuildContext context) => ConsentDialog(
                        onConsent: onConsent,
                      ),
                  context: context),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Widget child;
  final bool enabled;

  const LoginButton({Key key, this.onPressed, this.text, this.enabled = false, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: enabled,
      child: (child == null)
          ? RaisedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Icon(Icons.mail, color: Colors.black,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text, style: TextStyle(fontSize: 16),),
              )
            ],),
            onPressed: enabled ? onPressed : null,
          )
      : Padding(
        padding: EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
