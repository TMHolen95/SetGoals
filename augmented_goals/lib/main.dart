import 'package:augmented_goals/util/authentication.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:augmented_goals/util/appNavigation.dart';
import 'package:augmented_goals/util/notification.dart';
import 'package:augmented_goals/widgets/example/sensor_page.dart';
import 'package:augmented_goals/widgets/routes/dialogs/confirm_dialog.dart';
import 'package:augmented_goals/widgets/routes/home_page.dart';
import 'package:augmented_goals/widgets/routes/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await FirestoreAPI.setupFirestore();
  FirebaseUser user = await Auth.getCurrentUser();
  Auth.firebaseUser = user;
  if (user != null) {
    await FirestoreAPI.setExistingAccount();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static LocalNotifications of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LocalNotifications)
        as LocalNotifications);
  }

  static PendingMessage messageOf(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PendingMessage)
        as PendingMessage);
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Widget notification = Container();
  bool notificationVisible = false;

  Map<String, dynamic> message;

  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  @override
  void initState() {
    super.initState();
    FirestoreAPI.firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        displayNotification(message);
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        //AppNavigator.handleMessage(navigatorKey.currentContext, message,  onLaunch: true);
        setState(() {
          this.message = message;
          print("onLaunch: $message");
        });
      },
      onResume: (Map<String, dynamic> message) async {
        AppNavigator.handleMessage(navigatorKey.currentContext, message,
            onResume: true);
        print("onResume: $message");
      },
    );

    FirestoreAPI.firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    FirestoreAPI.firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    FirestoreAPI.firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    Widget app = MaterialApp(
        navigatorKey: navigatorKey,
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'Augmented Goals',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
              title: TextStyle(
                fontSize: 28.0,
                fontStyle: FontStyle.italic,
              ),
              body1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
              body2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              subtitle: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            )),
        home: (Auth.firebaseUser != null)
            ? AuthenticationEvaluation()
            : LoginPage(),
        routes: <String, WidgetBuilder>{
          // Set routes for using the Navigator.
          '/home': (BuildContext context) => AuthenticationEvaluation(),
          '/login': (BuildContext context) => LoginPage(),
          '/sensor': (BuildContext context) => SensorPage(),
        });

    // Solution to get notifications in activities started by the navigator.

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime augmentedgoals.augmentedgoals.com/',
        'repeatDailyAtTime resourceResolver',
        'repeatDailyAtTime repeats notification');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    Widget wrappedApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: <Widget>[
          LocalNotifications(
              notificationDetails: platformChannelSpecifics,
              plugin: flutterLocalNotificationsPlugin,
              child: PendingMessage(
                  message: this.message,
                  navigatorKey: this.navigatorKey,
                  child: app)),
          notification,
          /*Center(
            child: RaisedButton(
                onPressed: () async => flutterLocalNotificationsPlugin.show(
                    1568,
                    "Hello",
                    "Well hello again",
                    platformChannelSpecifics)),
          )*/
        ],
      ),
    );

    return wrappedApp;
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await showDialog(
                      context: context,
                      builder: (context) => ConfirmDialog(
                            title: "Your Received a notification!",
                            text: "What to do?",
                          ));
                },
              )
            ],
          ),
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
              title: "Your Received a notification!",
              text: "What to do?",
            ));
  }

  void displayNotification(Map<String, dynamic> message) {
    setState(() {
      notificationVisible = true;
      notification = AnimatedNotification(
        makeVisible: true,
        message: message,
      );
    });
    Future.delayed(Duration(seconds: 4)).then((res) => setState(() {
          notificationVisible = false;
          notification = AnimatedNotification(
            makeVisible: false,
            message: message,
          );
          Future.delayed(Duration(milliseconds: 500))
              .then((res) => setState(() {
                    notification = Container();
                  }));
        }));
  }
}

/// Allows other widgets own the tree access to the index and position.
class LocalNotifications extends InheritedWidget {
  final FlutterLocalNotificationsPlugin plugin;
  final NotificationDetails notificationDetails;

  LocalNotifications(
      {Key key, this.notificationDetails, this.plugin, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(LocalNotifications oldWidget) {
    return true;
  }
}

class PendingMessage extends InheritedWidget {
  final GlobalKey navigatorKey;
  final Map<String, dynamic> message;

  PendingMessage({Key key, this.navigatorKey, this.message, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
