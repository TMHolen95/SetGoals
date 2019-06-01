import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/util/firestore_api.dart';

class ViewAccountBloc {
  final Future<Account> account;
  final Future<bool> isFriend;
  final Stream<bool> friendRequestSent;
  final Stream<int> pendingFriendRequests;
  final bool myAccount;

  factory ViewAccountBloc(String accountId) {
    print("View Account: " + accountId);
    bool myAccount = FirestoreAPI.isCurrentAccount(accountId);
    print("Is my account: " + myAccount.toString());
    Future<Account> accountToView =
        FirestoreAPI.getFullAccount(accountId: accountId);

    Future<bool> isFriend = FirestoreAPI.isFriend(accountId);

    Stream<bool> friendRequestSent;
    if(!myAccount){
      friendRequestSent = FirestoreAPI.sentFriendRequest(accountId: accountId);
    } else{
      friendRequestSent = null;
    }

    Stream<int> pendingFriendRequests =
        !myAccount ? Stream.empty() : FirestoreAPI.pendingFriendRequests();

    return ViewAccountBloc._(accountToView, isFriend, myAccount,
        pendingFriendRequests, friendRequestSent);
  }

  ViewAccountBloc._(this.account, this.isFriend, this.myAccount,
      this.pendingFriendRequests, this.friendRequestSent);

  void addFriend(Account account) {
    FirestoreAPI.sendFriendRequest(account);
  }
}
