import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendListBloc {
  final Stream<QuerySnapshot> accounts;

  factory FriendListBloc(String accountId){
    final accounts = FirestoreAPI.getFriends(accountId);
    return FriendListBloc._(accounts);
  }

  FriendListBloc._(this.accounts);



}