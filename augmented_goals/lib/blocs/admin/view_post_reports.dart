import 'dart:async';

import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewPostReportsBloc {

  Stream<Iterable> get initialState => null;
  Stream<QuerySnapshot> content = FirestoreAPI.getReportedPosts();

  onReportedPostAccepted(Post post){
    print("onReportedPostAccepted: accepted");
    FirestoreAPI.reportedPostKeep(post.postId);
  }

  onReportedPostDeclined(Post post){
    print("onReportedPostAccepted: declined");
    FirestoreAPI.reportedPostRemoval(post.postId);
  }
}