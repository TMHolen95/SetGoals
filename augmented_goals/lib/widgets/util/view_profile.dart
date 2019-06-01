import 'package:augmented_goals/blocs/view_account.dart';
import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/util/appNavigation.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/friendlist.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/quiz_bfi.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/view_friend_goals.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/view_friend_posts.dart';
import 'package:augmented_goals/widgets/util/account_image.dart';
import 'package:augmented_goals/widgets/util/text.dart';
import 'package:augmented_goals/widgets/util/toggle_icon.dart';
import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  final ViewAccountBloc bloc;

  const ViewProfile({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget buildBody = FutureBuilder(
        future: bloc.account,
        builder: (BuildContext context, AsyncSnapshot<Account> snapshot) {
          Account account = snapshot.data;
          if (account == null) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ));
          }
          final Widget header = Card(
            margin: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => null , // TODO add check if user is owner and allow user to upload new profile image.
                    child: AccountImage(
                      account.accountPictureUrl, height: 60, width: 60,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Headline(account.name),
                      InfoRow(
                        friends: account.friendCount,
                        goalsCreated: account.goalsCreated,
                        goalsCompleted: account.goalsCompleted,
                        onViewFriends: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FriendList(
                                      accountId: snapshot.data.accountId,
                                    )),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );

          final Widget points = Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Tooltip(
                  message: "Awarded when posting publicly and when adding friends",
                  child: PointTile(
                    iconData: Icons.public,
                    pointType: "Social Points",
                    points: account.socialPoints,
                  ),
                ),
                Tooltip(
                  message: "Awarded when creating new challenges in your community",
                  child: PointTile(
                    iconData: Icons.build,
                    pointType: "Creativity Points",
                    points: account.creativityPoints,
                  ),
                ),
                Tooltip(

                  message: "Awarded when you log data on a goal or complete goals ",
                  child: PointTile(
                      iconData: Icons.directions_run,
                      pointType: "Activity points",
                      points: account.activityPoints),
                )
              ],
            ),
          );

          final Widget profileHeader = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[header, points],
          );

          /*final Widget playerType = Visibility(
              visible: bloc.myAccount,
              child: GestureDetector(
                  onTap: () {
                    if (bloc.myAccount) {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PlayerTypeQuiz(
                                      accountId: snapshot.data.accountId)));
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(account.playerType == null
                                  ? "What player type are you?"
                                  : "Player Type: " + account.playerType,
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )));*/

          final Widget bfi = Visibility(
              visible: bloc.myAccount,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Questionnaires & Prize Draw", style: Theme.of(context).textTheme.headline,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "By participating in the questionnaires one can qualify for a prize draw. Please see the rules for more information, and ensure you have consented to the rules to qualify for participation in the prize draw.\n\n"
                            "The five winners can choose between a 200kr gift card on CC or alternatively a 25\$ gift card on Amazon. This prize draw is NOT affiliated with Apple, Google or any other third-parties.",

                        style: Theme
                            .of(context)
                            .textTheme
                            .caption,),
                    ),
                    FlatButton(onPressed: () => AppNavigator.viewContestRules(context), child: Text("View Rules & Consent")),

                    RaisedButton(onPressed: () =>
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => BfiQuiz())),
                        child: Column(
                          children: <Widget>[


                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Click to take the BFI test",
                                      style: TextStyle(fontSize: 12,
                                        fontWeight: FontWeight.bold,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(account.bfiTaken ?? false ? Icons
                                      .check : Icons
                                      .check_box_outline_blank,
                                  color: (account.bfiTaken ?? false)
                                      ? Colors.green
                                      : Colors.black),
                                )
                              ],
                            ),
                          ],
                        )),

                    Visibility(
                      visible: account.bfiTaken ?? false,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(child: Text("See available questionnaires"),
                          onPressed: () => AppNavigator.viewQuizzes(context),),
                      ),
                    )
                  ],
                ),
              ));

          final Widget tabHeader = Container(
            decoration: ShapeDecoration(shape: RoundedRectangleBorder()),
            child: Card(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CenteredTabTile(
                      text: "View Goals",
                      iconData: Icons.flag,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewFriendGoals(snapshot.data.accountId)),
                        );
                      },
                    ),
                    VerticalDivider(),
                    CenteredTabTile(
                      text: "View Posts",
                      iconData: Icons.assignment,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewFriendPosts(snapshot.data.accountId)),
                        );
                      },
                    )
                  ]),
            ),
          );

          final Widget addFriend = StreamBuilder(
              stream: bloc.friendRequestSent,
              builder: (BuildContext context, AsyncSnapshot<bool> ifSent) {
                if (ifSent.data == null) {
                  return Text("Loading...");
                }

                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      CenteredTabTile(
                        icon: ToggleIcon(
                          state: ifSent.data,
                          isTrue: Icons.hourglass_full,
                          isFalse: Icons.person_add,
                          purpose: TogglePurpose.ShowEnabledIcon,
                        ),
                        text: "Add Friend",
                        onTap: () {
                          bloc.addFriend(snapshot.data);
                        },
                      )
                    ],
                  ),
                );
              });

          final Widget ifFriend = FutureBuilder(
              future: bloc.isFriend,
              initialData: null,
              builder: (BuildContext context, AsyncSnapshot<bool> isFriend) {
                if (isFriend == null || isFriend.data == null) {
                  return Text("Loading...");
                }
                print(
                    "Viewing: " + snapshot.data.name + snapshot.data.accountId);
                print("My account: " +
                    bloc.myAccount.toString() +
                    ", Is friend: " +
                    isFriend.data.toString());
                if (bloc.myAccount || isFriend.data) {
                  return tabHeader;
                } else {
                  return addFriend;
                }
              });

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[profileHeader, ifFriend, bfi],
          );
        });

    return SingleChildScrollView(child: buildBody);
  }
}

class InfoRow extends StatelessWidget {
  final int friends;
  final VoidCallback onViewFriends;
  final int goalsCreated;
  final VoidCallback onViewGoals;
  final int goalsCompleted;
  final VoidCallback onViewChallenges;

  const InfoRow({Key key,
    this.friends,
    this.goalsCreated,
    this.goalsCompleted,
    this.onViewFriends,
    this.onViewGoals,
    this.onViewChallenges})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Tooltip(
          message: "Friends",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onViewFriends,
              child: Row(
                children: <Widget>[
                  Icon(Icons.group),
                  Text(": $friends"),
                ],
              ),
            ),
          ),
        ),
        Tooltip(
          message: "Goals Created",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onViewGoals,
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_box),
                  Text(": $goalsCreated"),
                ],
              ),
            ),
          ),
        ),
        Tooltip(
          message: "Goals Completed",
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onViewChallenges,
              child: Row(
                children: <Widget>[
                  Icon(Icons.flag),
                  Text(": $goalsCompleted"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// An ToggleIcon xor IconData must be provided, color affect only IconData and text.
class CenteredTabTile extends StatelessWidget {
  final ToggleIcon icon;
  final IconData iconData;
  final Color color;
  final String text;
  final VoidCallback onTap;

  const CenteredTabTile(
      {Key key, this.icon, this.iconData, this.color, this.text, this.onTap})
      : super(key: key);

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tab(
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon ?? Icon(iconData, color: color ?? Colors.black),
              Container(
                width: 4.0,
              ),
              Text(
                text,

                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PointTile extends StatelessWidget {
  final IconData iconData;
  final String pointType;
  final int points;

  const PointTile({Key key, this.iconData, this.pointType, this.points})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            pointType,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: <Widget>[
              Icon(iconData),
              Container(
                width: 4.0,
              ),
              Text(points.toString())
            ],
          ),
        ),
      ],
    );
  }
}
