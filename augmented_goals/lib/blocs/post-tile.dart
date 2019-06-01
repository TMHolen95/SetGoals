import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/util/firestore_api.dart';

class PostTileBloc {
  Post post;
  String accountId;

  PostTileBloc(Post post) {
    this.post = post;
    this.accountId = post.goal.account.accountId;
  }

  imageReference() {
    if(post.fileName != null){
      return FirestoreAPI.getStorageReferencePost(accountId, post.fileName);
    } else {
      return null;
    }
  }

  deletePost(String documentId) {
    FirestoreAPI.deletePost(documentId);
  }

  bool isPostOwner() {
    return FirestoreAPI.isCurrentAccount(accountId);
  }

  String postReference() {
    return FirestoreAPI.collectionPostOf(accountId)
        .reference()
        .document(post.postId)
        .path;
  }
}
