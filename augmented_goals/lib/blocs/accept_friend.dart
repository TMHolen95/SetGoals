import 'package:augmented_goals/data_classes/friend_request.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcceptFriendBloc{
  final Stream<QuerySnapshot> friendRequests;

  factory AcceptFriendBloc(){
    final friendRequests = FirestoreAPI.getFriendRequests();
    return AcceptFriendBloc._(friendRequests);
  }

  AcceptFriendBloc._(this.friendRequests);

  Future<bool> onAcceptRequest(FriendRequest request){
    return FirestoreAPI.answerFriendRequest(request, true);
  }

  Future<bool> onDeclineRequest(FriendRequest request){
    return FirestoreAPI.answerFriendRequest(request, false);
  }
}