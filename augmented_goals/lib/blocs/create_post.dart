import 'dart:async';
import 'dart:io';

import 'package:augmented_goals/data_classes/enum/goal_status.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class PostState {
  // For creating Post object
  String orientation;
  String fileName = "";
  String title = "";
  String message = "";
  GoalStatus postStatus = GoalStatus.unchanged;

  int width;
  int height;

  // For widget functionality
  File file;
  bool uploading = false;
  String error;

  PostState();
}

class CreatePostBloc {
  Goal goal;
  DocumentSnapshot goalReference;
  Post postToCreate;

  StreamController<PostState> postStateController = StreamController<PostState>();
  Sink get updatePostState => postStateController.sink;
  Stream<PostState> get postState => postStateController.stream;

  CreatePostBloc(Goal goal, DocumentSnapshot goalReference) {
    this.goal = goal;
    this.goalReference = goalReference;
  }

  CreatePostBloc._(this.goal, this.goalReference, this.postStateController);

  PostState initial() {
    return PostState();
  }

  void dispose() {
    postStateController.close();
  }

  deletePost(String documentId) {
    FirestoreAPI.deleteGoal(documentId);
  }

  Future<void> uploadPost(PostState state) async {
    state.uploading = true;
    updatePostState.add(state);

    if(state.file != null){
      await uploadFile(state);
    }

    Post post = buildPost(state);
    FirestoreAPI.updateGoal(post.goal);
    FirestoreAPI.createPost(post);
  }

  Post buildPost(PostState state) {
    GoalBuilder builder = goal.toBuilder()
      ..state = state.postStatus
      ..active = state.postStatus == GoalStatus.completed ? false : true;
    ListBuilder<String> uids = ListBuilder()..add(goal.account.accountId);

    if(state.file != null){
      return Post((b) => b
        ..postId = Uuid().v1()
        ..title = state.title
        ..message = state.message
        ..width = state.width
        ..height = state.height
        ..goal = builder
        ..fileName = state.fileName
        ..uids = uids
        ..timestamp = Timestamp.now());
    } else {
      return Post((b) => b
        ..postId = Uuid().v1()
        ..title = state.title
        ..message = state.message
        ..goal = builder
        ..uids = uids
        ..timestamp = Timestamp.now());
    }

  }

  void updateFile(PostState state, File file) {
    state.file = file;
    state.error = null;
    updatePostState.add(state);
  }

  /// Update does not add to sink,
  /// If file is already set it prevents a flash as it is changed during rebuild.
  /// Todo Use in release when not debugging rotation.
  void updateFileSilently(PostState state, File file) {
    state.file = file;
    state.error = null;
  }

  /// Update does not add to sink
  void updateDimensionsSilently({PostState state, int width, int height}) {
    state.width = width;
    state.height = height;
  }

  void noImageAttached(PostState state) {
    state.error = "Please attach an image!";
    updatePostState.add(state);
  }

  Future<StorageTaskSnapshot> uploadFile(PostState state) async {
    print(state.file.path);
    state.fileName = basename(state.file.path);
    updatePostState.add(state); // Send the changed state

    print(state.fileName);
    final StorageReference ref = FirestoreAPI.storage
        .ref()
        .child('user')
        .child(FirestoreAPI.account.accountId)
        .child(state.fileName);
    final StorageUploadTask uploadTask = ref.putFile(
      state.file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{
          'owner': FirestoreAPI.account.accountId
        },
      ),
    );
    return uploadTask.onComplete;
  }

  List<GoalStatus> getPostStates() {
    List<GoalStatus> statuses = GoalStatus.values.toList()
      ..remove(GoalStatus.newGoal);
    print(statuses);
    return statuses;
  }

  void setGoalState(PostState state, String status) {
    state.postStatus = GoalStatus.valueOf(status);
    updatePostState.add(state);
  }

  String capitalizedGoalState(GoalStatus value) {
    return GoalStatus.asString(value);
  }
}
