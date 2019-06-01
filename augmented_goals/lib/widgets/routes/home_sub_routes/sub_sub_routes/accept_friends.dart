import 'package:augmented_goals/blocs/accept_friend.dart';
import 'package:augmented_goals/data_classes/friend_request.dart';
import 'package:augmented_goals/data_classes/serializers.dart';
import 'package:augmented_goals/widgets/list_tiles/friend_request_tile.dart';
import 'package:augmented_goals/widgets/util/go_back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AcceptFriends extends StatefulWidget {
  @override
  AcceptFriendsState createState() => AcceptFriendsState();
}

class AcceptFriendsState extends State<AcceptFriends> {
  AcceptFriendBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AcceptFriendBloc();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBody = StreamBuilder(
        stream: bloc.friendRequests,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null || !snapshot.hasData){
            return Center(child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("All Good!"),
              ],
            ));
          }
          print("Documents: " + snapshot.data.documents.length.toString());
          return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
            print(document.data);
            FriendRequest friendRequest = mySerializers.deserializeWith(
                FriendRequest.serializer, document.data);
            print(friendRequest.toString());
            return FriendRequestTile(
              sender: friendRequest.sender,
              onAccept: () => bloc.onAcceptRequest(friendRequest),
              onDecline: () => bloc.onDeclineRequest(friendRequest),
            );
          }).toList());
        });

    return Scaffold(
        appBar: AppBar(
          leading: GoBackButton(),
          title: Text("Pending Friend Requests"),
        ),
        body: buildBody);
  }
}


