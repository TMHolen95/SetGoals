import 'package:augmented_goals/blocs/authentication_check.dart';
import 'package:augmented_goals/blocs/index.dart';
import 'package:augmented_goals/main.dart';
import 'package:augmented_goals/util/appNavigation.dart';
import 'package:augmented_goals/util/authentication.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/exploration_map.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/goal_feed.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/home_feed.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();

  static HomePageState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MyInheritedWidget)
            as MyInheritedWidget)
        .data;
  }
}

class HomePageState extends State<HomePage> {
  IndexBloc indexBloc;
  IndexState lastState;

  @override
  void initState() {
    super.initState();
    indexBloc = IndexBloc();
  }

  @override
  Widget build(BuildContext context) {



    return StreamBuilder(
      initialData: indexBloc.initial(),
      stream: indexBloc.stream,
      builder: (context, snapshot) {
        IndexState state = snapshot.data;
        lastState = state;
        // Assigns the correct page according to index
        Widget page;
        if (state.index == 0) {
          page = HomeFeed();
        } else if (state.index == 1) {
          page = GoalFeed();
        } else if (state.index == 2) {
          page = ExplorationMap();
        } else if (state.index == 3) {
          page = MyProfile();
        }

        Map<String, dynamic> message = MyApp.messageOf(context).message;
        print("HomePage: message - ${message.toString()}");
        if(message?.isNotEmpty ?? false){
          print("HomePage: triggering appNavigator from message");
          AppNavigator.handleMessage(context, message, onLaunch: true);
        }
        // Returns a inherited widget that allows access to the index from
        // any widget down in the widget tree.
        return MyInheritedWidget(data: this, child: page);
      },
    );
  }
}

/// Allows other widgets own the tree access to the index and position.
class MyInheritedWidget extends InheritedWidget {
  final HomePageState data;

  MyInheritedWidget({Key key, this.data, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return true;
  }
}

class AuthenticationEvaluation extends StatefulWidget {
  @override
  _AuthenticationEvaluationState createState() => _AuthenticationEvaluationState();
}

class _AuthenticationEvaluationState extends State<AuthenticationEvaluation> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: Auth.firebaseUser,
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          // Signs out the user if the logged in state changes.
          print("Authentication state changed!");
          if (snapshot.data == null) {
            print(
                "Authentication state snapshot is null - redirecting to login!");
            Future.delayed(Duration(milliseconds: 50)).then((res) {
              Navigator.pushReplacementNamed(context, '/login');
            });
            return Container();
          }else{
            return HomePage();
          }
        });
  }
}



class Authenticated extends StatefulWidget {
  @override
  _AuthenticatedState createState() => _AuthenticatedState();
}

class _AuthenticatedState extends State<Authenticated> {
  AuthenticationCheckBloc authBloc;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authBloc.signedIn(),
      builder: (context, userSnapshot) {
        print("User: ${userSnapshot.data}");
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          print("Waiting");
          return Center(child: CircularProgressIndicator());

        } else if (userSnapshot.connectionState == ConnectionState.done) {
          print("Done");
          if (userSnapshot.data == false) {
            Future.delayed(Duration(milliseconds: 50)).then((res) {
              Navigator.pushReplacementNamed(context, '/login');
            });
            return Container();
          } else {
            // Check if a message was clicked
            PendingMessage pendingMessage = MyApp.messageOf(context);
            if (pendingMessage.message != null) {
              AppNavigator.handleMessage(
                  pendingMessage.navigatorKey.currentContext,
                  pendingMessage.message,
                  onLaunch: true);
            }
            return AuthenticationEvaluation();
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    authBloc = AuthenticationCheckBloc();
  }
}
