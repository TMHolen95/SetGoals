import 'dart:async';

import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentingState{
  bool commentingAllowed = false;
  String comment;
  CommentingState();
}

class CommentBloc{
  Post post;
  Stream<QuerySnapshot> commentStream;

  StreamController<CommentingState> commentingStateController = StreamController<CommentingState>();
  Sink get updateCommentingState => commentingStateController.sink;
  Stream<CommentingState> get stream => commentingStateController.stream;


  CommentBloc(Post post){
    this.post = post;
    this.commentStream = FirestoreAPI.getCommentsFromPost(post);
  }

  CommentBloc._(this.commentStream, this.post);

  Future<void> sendComment(CommentingState state) {
    return FirestoreAPI.createComment(post, state.comment);
  }



  CommentingState initial(){
    return CommentingState();
  }
  void dispose(){
    commentingStateController.close();
  }

  void _update(CommentingState state){
    updateCommentingState.add(state);
  }

  void updateCommentingAllowed(CommentingState state, bool commentingAllowed){
    state.commentingAllowed = commentingAllowed;
    _update(state);
  }

  void updateComment(CommentingState state, String comment){
    state.comment = comment;
    if(comment.isNotEmpty){
      state.commentingAllowed = true;
    } else {
      state.commentingAllowed = false;
    }
    _update(state);
  }

}



