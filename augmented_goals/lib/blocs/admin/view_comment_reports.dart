import 'dart:async';

import 'package:augmented_goals/data_classes/comment.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewCommentReportsBloc {

  Stream<Iterable> get initialState => null;
  Stream<QuerySnapshot> content = FirestoreAPI.getReportedComments();

  onReportedCommentAccepted(Comment comment){
    FirestoreAPI.reportedCommentKeep(comment.commentId);
  }

  onReportedCommentDeclined(Comment comment){
    FirestoreAPI.reportedCommentRemoval(comment.commentId);
  }
}