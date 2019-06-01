import 'package:augmented_goals/blocs/friendlist.dart';
import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/data_classes/serializers.dart';
import 'package:augmented_goals/widgets/list_tiles/account_tile.dart';
import 'package:augmented_goals/widgets/list_tiles/text_tile.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/view_account.dart';
import 'package:augmented_goals/widgets/util/go_back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FriendList extends StatefulWidget {
  final String accountId;

  const FriendList({Key key, this.accountId}) : super(key: key);
  @override
  FriendListState createState() => FriendListState();
}

class FriendListState extends State<FriendList> {
  FriendListBloc bloc;

  @override
  void initState() {
    super.initState();
    this.bloc = FriendListBloc(widget.accountId);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBody = StreamBuilder(
        stream: bloc.accounts,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading..."),
                ),
              ],
            );
          }
          print("Documents: " + snapshot.data.documents.length.toString());
          if (snapshot.data.documents.isEmpty)
            return TextTile(
              message: "No friends yet, why not invite some friends?",
            );
          return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
            print(document.data);
            Account account = mySerializers.deserializeWith(
                Account.serializer, document.data);
            /*print("Friendlist: " + account.toString());*/
            return AccountTile(
              account: account,
              onViewFriend: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        print("Friendlist: " + account.name + account.accountId);
                        return ViewAccount(
                          accountId: account.accountId,
                        );
                      }),
                );
              },
            );
          }).toList());
        });

    return Scaffold(
        appBar: AppBar(
          leading: GoBackButton(),
          title: Text("Friendlist"),
        ),
        body: buildBody);
  }
}
