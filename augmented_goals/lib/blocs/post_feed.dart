import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostFeedBloc {
  Stream<QuerySnapshot> posts;

  factory PostFeedBloc({accountId}) {
    final Stream<QuerySnapshot> posts = accountId == null
        ? FirestoreAPI.getUserFeedStream()
        : FirestoreAPI.getPublicPosts(accountId: accountId);
    return PostFeedBloc._(posts);
  }

  QuerySnapshot initial() {
    return null;
  }

  PostFeedBloc._(this.posts);

  deletePost(String documentId) {
    FirestoreAPI.deletePost(documentId);
  }

  static bool isPostOwner(Post post){
    return post.goal.account.accountId == FirestoreAPI.account.accountId;
  }
}
