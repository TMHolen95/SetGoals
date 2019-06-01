import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/widgets/util/account_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountTile extends StatelessWidget {
  final Account account;
  final VoidCallback onViewFriend;

  const AccountTile({Key key, this.account, this.onViewFriend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: onViewFriend,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: AccountImage(account.accountPictureUrl, width: 50.0, height: 50.0,),
            title: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(account.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
