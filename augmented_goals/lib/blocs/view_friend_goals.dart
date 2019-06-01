import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewFriendGoalsBloc{
  final Stream<QuerySnapshot> goals;

  factory ViewFriendGoalsBloc(String accountId){
    Stream<QuerySnapshot> goals = FirestoreAPI.getPublicGoals(accountId: accountId);
    return ViewFriendGoalsBloc._(goals);
  }

  ViewFriendGoalsBloc._(this.goals);
}