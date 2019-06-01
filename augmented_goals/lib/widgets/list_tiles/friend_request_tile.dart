import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/widgets/util/accept_reject_button.dart';
import 'package:augmented_goals/widgets/util/account_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FriendRequestTile extends StatelessWidget {
  final Account sender;
  final VoidCallback onDecline;
  final VoidCallback onAccept;

  const FriendRequestTile({Key key, this.sender, this.onDecline, this.onAccept})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: AccountImage(sender.accountPictureUrl, height: 50, width: 50,),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(child: Text(sender.name)),
            ],
          ),
          trailing: AcceptRejectButton(
            onAccept: onAccept,
            onReject: onDecline,
          ),
        ),
      ),
    );
  }
}
