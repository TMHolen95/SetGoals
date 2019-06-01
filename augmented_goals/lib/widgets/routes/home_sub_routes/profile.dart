import 'package:augmented_goals/blocs/view_account.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/accept_friends.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/util/app_bar_actions.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/find_friends.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/util/navigation_bar.dart';
import 'package:augmented_goals/widgets/util/logo_image.dart';
import 'package:augmented_goals/widgets/util/view_profile.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> implements AppBarActions {
  ViewAccountBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ViewAccountBloc(FirestoreAPI.account.accountId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: HomeImage(Icons.person),
          title: Text("Profile"),
          actions: appBarActions(),
        ),
        bottomNavigationBar: NavigationBar(),
        body: ViewProfile(bloc: bloc,));
  }

  @override
  List<Widget> appBarActions() {
    List<Widget> actions = <Widget>[
      IconButton(
          icon: Icon(Icons.person_add),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FindFriends()),
            );
          }),
      IconButton(
          icon: Stack(
              children: <Widget>[Icon(Icons.group), pendingFriendRequests()]),
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AcceptFriends()));
          })
    ];
    AppBarActions.appendDefaultActions(actions, context);
    return actions;
  }

  Widget pendingFriendRequests() {
    return StreamBuilder(
        initialData: 0,
        stream: bloc.pendingFriendRequests,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.data == null || snapshot.data == 0){
            return Container(width: 0.0,height: 0.0,);
          }
          print("Snapshot data: " + snapshot.data.toString());
          return Positioned(
              // draw a red marble
              left: 0.0,
              bottom: 0.0,
              child: Container(
                decoration: ShapeDecoration(color: Colors.yellow,shape: CircleBorder(side: BorderSide(color: Colors.yellow))),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    snapshot.data.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 10.0),
                  ),
                ),
              ));
        });
  }
}


