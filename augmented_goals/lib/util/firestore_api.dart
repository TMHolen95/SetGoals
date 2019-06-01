import 'dart:io';

import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/data_classes/comment.dart';
import 'package:augmented_goals/data_classes/enum/goal_category.dart';
import 'package:augmented_goals/data_classes/enum/goal_status.dart';
import 'package:augmented_goals/data_classes/friend_request.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/data_classes/log_entry.dart';
import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/data_classes/question.dart';
import 'package:augmented_goals/data_classes/quiz.dart';
import 'package:augmented_goals/data_classes/reminder.dart';
import 'package:augmented_goals/data_classes/reported_content.dart';
import 'package:augmented_goals/data_classes/serializers.dart';
import 'package:augmented_goals/util/authentication.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:augmented_goals/questionnaire_system/question_data.dart';
import 'package:uuid/uuid.dart';

abstract class FirestoreAPI {
  static Firestore _inst = Firestore.instance;
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // TODO ensure that _account.accountId always equals user.uid().
  static Account _account;

  static Account get account => _account;

  static FirebaseMessaging get firebaseMessaging => _firebaseMessaging;

  static FirebaseStorage get storage => _storage;

  static Future<void> setupFirestore() async {
    await _inst.settings(timestampsInSnapshotsEnabled: true);
  }

  static Future<DocumentSnapshot> getSnapshot() {
    return Firestore.instance.collection("some-path").document("some-id").get();
  }

  //static FirebaseApp _app;
  static final FirebaseStorage _storage =
      FirebaseStorage(app: Firestore.instance.app);

  static void createGoal(Goal goal) async {
    final value = mySerializers.serializeWith(Goal.serializer, goal);
    await collectionGoalOfCurrentUser().document(goal.goalId).setData(value);
  }

  static void createChallenge(Challenge challenge) async {
    final value = mySerializers.serializeWith(Challenge.serializer, challenge);
    await collectionChallenge().document(challenge.challengeId).setData(value);
  }

  static Stream<QuerySnapshot> getUserGoalStream() {
    return collectionGoalOfCurrentUser().snapshots();
  }

  static Stream<QuerySnapshot> getUserFeedStream() {
    return collectionFeedOfCurrentUser()
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getUserPostStream() {
    return collectionPostOfCurrentUser().snapshots();
  }

  static Future addChallengeToUserGoalList(Challenge challenge) async {
    Goal goal = Goal((b) => b
      ..state = GoalStatus.newGoal
      ..account = Account.minimal(_account).toBuilder()
      ..active = false
      ..state = GoalStatus.newGoal
      ..title = challenge.title
      ..description = challenge.description
      ..category = challenge.category
      ..goalId = challenge.challengeId
      ..challengeId = challenge.challengeId
      ..position = challenge.position
      ..public = true);

    final value = mySerializers.serializeWith(Goal.serializer, goal);
    await collectionGoalOfCurrentUser()
        .document(challenge.challengeId)
        .setData(value);
    return;
  }

  static void createPost(Post post) async {
    final data = mySerializers.serializeWith(Post.serializer, post);
    await collectionPostOfCurrentUser().document(post.postId).setData(data);
  }

  static Stream<QuerySnapshot> getPublicChallenges() {
    return collectionChallenge().snapshots();
  }

  static Future<QuerySnapshot> getPublicChallengeDocuments() async {
    return collectionChallenge().getDocuments();
  }

  static Future<List<Challenge>> getChallenges() async {
    List<Challenge> challenges = <Challenge>[];
    QuerySnapshot qs = await FirestoreAPI.getPublicChallengeDocuments();
    qs.documents.forEach((ds) => challenges
        .add(mySerializers.deserializeWith(Challenge.serializer, ds.data)));
    return challenges;
  }

  static Future<void> deleteGoal(String documentId) async {
    Firestore.instance.runTransaction((Transaction tx) async {
      await collectionGoalOfCurrentUser().document(documentId).delete();
    });
  }

  static Future<DocumentSnapshot> getCurrentAccount() async {
    return collectionAccount().document(Auth.firebaseUser.uid).get();
  }

  static Future<Account> getFullAccount({String accountId}) async {
    DocumentSnapshot s = await collectionAccount()
        .document(accountId ?? Auth.firebaseUser.uid)
        .get();
    return mySerializers.deserializeWith(Account.serializer, s.data);
  }

  static Stream<QuerySnapshot> getPosts(String accountId) {
    return collectionPostOf(accountId).snapshots();
  }

  static Stream<QuerySnapshot> getPublicPosts({String accountId}) {
    return collectionPostOf(accountId ?? _account.accountId)
        .where("goal.public", isEqualTo: true)
        .snapshots();
  }

  static getPublicGoals({String accountId}) {
    return collectionGoalOf(accountId)
        .where("public", isEqualTo: true)
        .snapshots();
  }

  static int _recursiveCount = 0;

  /// This method should be called after a cloud function have created the
  /// account in firestore. However this may take time so the data received from
  /// firestore may be null, so it recursively calls itself with a second delay
  /// between each call up to five times.
  static Future<void> setAccount() async {
    DocumentSnapshot currentAccount = await getCurrentAccount();
    if (currentAccount.data != null) {
      print(
          "Account set after $_recursiveCount recursive calls to setAccount()");
      _account = mySerializers.deserializeWith(
          Account.serializer, currentAccount.data);
      _recursiveCount = 0;
    } else {
      if (_recursiveCount < 5) {
        _recursiveCount++;
        await Future.delayed(Duration(milliseconds: 1000 * _recursiveCount))
            .then((result) => setAccount());
      }
    }
  }

  static Future<void> setExistingAccount() async {
    DocumentSnapshot currentAccount = await getCurrentAccount();
    print("AccountSnapshot: ${currentAccount.toString()}");
    _account =
        mySerializers.deserializeWith(Account.serializer, currentAccount.data);
  }

  static Future<String> getApplicationPath() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    return appDir.path;
  }

  static Future<List<Account>> searchForAccounts(String search) async {
    List<Account> accounts = <Account>[];
    QuerySnapshot qs = await collectionAccount()
        .where('nameLowerCase', isEqualTo: search.toLowerCase())
        .getDocuments();
    qs.documents.forEach((ds) => accounts.add(deserializeAccount(ds.data)));
    return accounts;
  }

  static Account deserializeAccount(Map<String, dynamic> data) {
    return mySerializers.deserializeWith(Account.serializer, data);
  }

  static Map<String, dynamic> serializeFriendRequest(
      Account sender, Account recipient) {
    FriendRequest request = FriendRequest((b) => b
      ..sender = sender.toBuilder()
      ..recipient = recipient.toBuilder()
      ..accepted = false
      ..timestamp = Timestamp.now());
    return mySerializers.serializeWith(FriendRequest.serializer, request);
  }

  static Future<bool> sendFriendRequest(Account recipient) async {
    Account sender = Account.minimal(_account);
    recipient = Account.minimal(recipient);

    bool result = true;
    var data = serializeFriendRequest(sender, recipient);
    print(data.toString());
    // Store the request in both the sender and recipients sent and received collections.
    await collectionSentFriendRequestOf(sender.accountId)
        .document(recipient.accountId)
        .setData(data)
        .catchError((error) {
      print(error.toString());
      result = false;
    });
    await collectionReceivedFriendRequestOf(recipient.accountId)
        .document(sender.accountId)
        .setData(data)
        .catchError((error) {
      print(error.toString());
      result = false;
    });
    return result;
  }

  static Future<bool> answerFriendRequest(
      FriendRequest request, bool response) async {
    bool result = true;
    FriendRequest updatedRequest =
        (request.toBuilder()..accepted = response).build();
    Map<String, dynamic> data =
        mySerializers.serializeWith(FriendRequest.serializer, updatedRequest);

    await collectionReceivedFriendRequestOf(updatedRequest.recipient.accountId)
        .document(updatedRequest.sender.accountId)
        .setData(data)
        .catchError((error) {
      print(error.toString());
      result = false;
    });

    // Firebase function handles the rest

    return result;
  }

  /// Should always be called from the recipient of a friend request
  static Future<bool> addFriend(FriendRequest request) async {
    bool result = true;

    Map<String, dynamic> data(Account account) {
      return mySerializers.serializeWith(Account.serializer, account);
    }

    // Add to own friendList
    await collectionFriendListOf(_account.accountId)
        .document(request.sender.accountId)
        .setData(data(request.sender))
        .catchError((e) {
      result = false;
    });

    // Add to friend's friendList
    await collectionFriendListOf(request.sender.accountId)
        .document(_account.accountId)
        .setData(data(request.recipient))
        .catchError((e) {
      result = false;
    });
    return result;
  }

  static Stream<QuerySnapshot> getFriendRequests() {
    print("Account: ${_account.toString()}");
    return collectionReceivedFriendRequestOf(_account.accountId).snapshots();
  }

  static Stream<QuerySnapshot> getFriends(String accountId) {
    return collectionFriendOf(accountId).snapshots();
  }

  static CollectionReference collectionFriendOf(String accountId) {
    return collectionAccount().document(accountId).collection('friends');
  }

  static CollectionReference collectionGoalOfCurrentUser() {
    return collectionAccount().document(_account.accountId).collection('goals');
  }

  static CollectionReference collectionGoalOf(String accountId) {
    return collectionAccount().document(accountId).collection('goals');
  }

  static CollectionReference collectionPostOfCurrentUser() {
    return collectionAccount().document(_account.accountId).collection('posts');
  }

  static CollectionReference collectionFeedOfCurrentUser() {
    print("Account: ${_account.toString()}");
    return collectionAccount().document(_account.accountId).collection('feed');
  }

  // TODO create these methods for all references to a collection using strings.
  static CollectionReference collectionAccount() {
    return _inst.collection('account');
  }

  static CollectionReference collectionChallenge() {
    return _inst.collection('challenge');
  }

  static CollectionReference collectionReceivedFriendRequestOf(
      String accountId) {
    return collectionAccount()
        .document(accountId)
        .collection('receivedFriendRequests');
  }

  static CollectionReference collectionSentFriendRequestOf(String accountId) {
    return collectionAccount()
        .document(accountId)
        .collection('sentFriendRequests');
  }

  static CollectionReference collectionFriendListOf(String accountId) {
    return collectionAccount().document(accountId).collection('friendList');
  }

  static CollectionReference collectionPostOf(String accountId) {
    return collectionAccount().document(accountId).collection('posts');
  }

  static CollectionReference collectionCommentOf(
      String accountId, String postId) {
    return collectionPostOf(accountId).document(postId).collection('comments');
  }

  static CollectionReference collectionDataRequestsOf(String accountId) {
    return collectionAccount().document(accountId).collection("dataRequests");
  }

  static Future<void> deletePost(String documentId) async {
    return collectionPostOf(_account.accountId).document(documentId).delete();
  }

  static Stream<QuerySnapshot> getCommentsFromPost(Post post) {
    return collectionCommentOf(post.goal.account.accountId, post.postId)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  static Account minimalCurrentAccount() {
    return Account.minimal(_account);
  }

  static void dislikeComment(Post post, String commentId) {
    var data = mySerializers.deserialize(minimalCurrentAccount());
    collectionCommentOf(post.goal.account.accountId, post.postId)
        .document(commentId)
        .collection('likes')
        .document(_account.accountId)
        .setData(data);
  }

  static void likeComment(Post post, String commentId) {
    var data = mySerializers.deserialize(minimalCurrentAccount());
    collectionCommentOf(post.goal.account.accountId, post.postId)
        .document(commentId)
        .collection('dislikes')
        .document(_account.accountId)
        .setData(data);
  }

  static Future<void> createComment(Post post, String commentText) {
    String commentId = Uuid().v1();
    Comment comment = Comment((builder) => builder
          ..commentId = commentId
          ..account = Account.minimal(_account).toBuilder()
          ..message = commentText
          ..timestamp = Timestamp.now()
        // TODO set timestamp and likes on the server
        );

    Map<String, dynamic> data = mySerializers.serialize(comment);
    return collectionCommentOf(post.goal.account.accountId, post.postId)
        .document(commentId)
        .setData(data);
  }

  static bool isCurrentAccount(String accountId) {
    return accountId == _account.accountId;
  }

  static Future<bool> isFriend(String accountId) {
    print("FirestoreAPI: isFriend() searched: " +
        _account.name +
        _account.accountId);
    return collectionFriendOf(_account.accountId)
        .where("accountId", isEqualTo: accountId)
        .limit(1)
        .getDocuments()
        .then((snapshot) {
      print("FirestoreAPI: isFriend() found: " +
          snapshot.documents[0]['accountId'].toString());
      return snapshot.documents[0].exists;
    }).catchError((error) {
      print("FirestoreAPI: isFriend() failed!");
      return false;
    });
  }

  static Stream<int> pendingFriendRequests() {
    return collectionReceivedFriendRequestOf(Auth.user().uid)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.documents.length);
/*        //.getDocuments()
        .then((results) {
      print("FirestoreAPI - pendingFriendRequests() - Length: " +
          results.documents.length.toString());
      return results.documents
          .toList()
          .length;
    }).catchError((error) {
      print("FirestoreAPI - pendingFriendRequests() failed!");
      return 0;
    });*/
  }

  static Stream<bool> sentFriendRequest({String accountId}) {
    return collectionSentFriendRequestOf(_account.accountId)
        .where("accountId", isEqualTo: accountId)
        .limit(1)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.documents.length == 1);
  }

  static void updatePlayerType(String playerType) {
    collectionAccount()
        .document(_account.accountId)
        .updateData({'playerType': playerType});
  }

  /// Validates if the fcm token from the users phone is stored on his profile.
  /// fcm tokens is stored in a sub-collection fcm for the user's account.
  static Future fcmTokenCoherencyCheck() async {
    String fcm = await firebaseMessaging.getToken();
    DocumentReference reference = collectionAccount()
        .document(Auth.firebaseUser.uid)
        .collection('fcm')
        .document('fcms');
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data;

    if (data == null) {
      data = {
        'fcms': [fcm]
      };
      await reference.setData(data);
    }
    if (data.containsKey('fcms')) {
      List<dynamic> fcms = List.from(data['fcms']);
      if (!fcms.contains(fcm)) {
        fcms.add(fcm);
        data['fcms'] = fcms;
        await reference.setData(data);
      }
    }
  }

  static Future fcmTokenRemoval() async {
    String fcm = await firebaseMessaging.getToken();
    DocumentReference reference = collectionAccount()
        .document(Auth.firebaseUser.uid)
        .collection('fcm')
        .document('fcms');
    print('fcmTokenRemoval - Reference: ${reference.path}');
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data;

    if (data == null) {
      print("fcmTokenRemoval - hit 'data == null' code");
      // This case should not happen
    } else if (data.containsKey('fcms')) {
      List<dynamic> fcms = List.from(data['fcms']);
      if (fcms.contains(fcm)) {
        fcms.remove(fcm);
        data['fcms'] = fcms;
        await reference.setData(data);
      }
    }
  }

  static Future<Post> getPost(String accountId, String documentId) async {
    DocumentSnapshot snapshot =
        await collectionPostOf(accountId).document(documentId).get();
    return mySerializers.deserializeWith(Post.serializer, snapshot.data);
  }

  /// Only specify one type of content
  static Future reportContent(String reportReason, String otherReason,
      DocumentReference originalReference,
      {Challenge challenge, Comment comment, Post post}) async {
    var reportableContent;
    DocumentReference ref;

    // Create a duplicate of the content in a root collection.
    // Firestore Rules will allow these to be created, but not updated.
    if (challenge != null) {
      ref = collectionReportedChallenge().document(challenge.challengeId);
      reportableContent =
          Challenge.reportableChallenge(challenge, originalReference);
    } else if (comment != null) {
      ref = collectionReportedComment().document(comment.commentId);
      reportableContent = Comment.reportableComment(comment, originalReference);
    } else if (post != null) {
      ref = collectionReportedPost().document(post.postId);
      reportableContent = Post.reportablePost(post, originalReference);
    }

    Map<String, dynamic> data = mySerializers.serialize(reportableContent);
    await ref.setData(data);
    print("Reporting Content");
    return generateReport(ref, reportReason, otherReason);
  }

  static Future generateReport(
      DocumentReference ref, String reportReason, String otherReason) async {
    // Generate a report based on the data from the user, in a sub-collection.
    ReportedContent userReport =
        ReportedContent.build(_account.accountId, reportReason, otherReason);
    Map<String, dynamic> serializedData = mySerializers.serialize(userReport);

    await ref
        .collection('reports')
        .document(_account.accountId)
        .setData(serializedData);
  }

  static Stream<QuerySnapshot> getReportedChallenges() {
    return collectionReportedChallenge()
        .where("handled", isEqualTo: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> getReportedComments() {
    return collectionReportedComment()
        .where("handled", isEqualTo: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> getReportedPosts() {
    return collectionReportedPost()
        .where("handled", isEqualTo: false)
        .snapshots();
  }

  static CollectionReference collectionReportedChallenge() {
    return _inst.collection('reportedChallenge');
  }

  static CollectionReference collectionReportedComment() {
    return _inst.collection('reportedComment');
  }

  static CollectionReference collectionReportedPost() {
    return _inst.collection('reportedPost');
  }

  static Future reportedChallengeKeep(String challengeId) {
    return reportedContentFate(
        collectionReportedChallenge(), true, challengeId);
  }

  static Future reportedChallengeRemoval(String challengeId) {
    return reportedContentFate(
        collectionReportedChallenge(), false, challengeId);
  }

  static Future reportedCommentKeep(String commentId) {
    return reportedContentFate(collectionReportedComment(), true, commentId);
  }

  static Future reportedCommentRemoval(String commentId) {
    return reportedContentFate(collectionReportedComment(), false, commentId);
  }

  static Future reportedPostKeep(String postId) {
    return reportedContentFate(collectionReportedPost(), true, postId);
  }

  static Future reportedPostRemoval(String postId) {
    return reportedContentFate(collectionReportedPost(), false, postId);
  }

  static Future reportedContentFate(
      CollectionReference ref, bool acceptable, String documentId) {
    return ref
        .document(documentId)
        .setData({"acceptable": acceptable, "handled": true}, merge: true);
  }

  static Future attachLogOptionsToGoal(Goal goal) {
    Map<String, dynamic> data = mySerializers.serialize(goal);
    return collectionGoalOfCurrentUser().document(goal.goalId).setData(data);
  }

  static Future addGoalLogEntry(String goalId, LogEntry entry) {
    Map<String, dynamic> data = mySerializers.serialize(entry);

    return collectionGoalLogEntriesOfCurrentUser(goalId)
        .document(entry.entryId)
        .setData(data);
  }

  static CollectionReference collectionGoalLogEntriesOfCurrentUser(
      String goalId) {
    return collectionGoalOfCurrentUser()
        .document(goalId)
        .collection("logEntries");
  }

  static Future updateGoal(Goal goal) {
    Map<String, dynamic> data = mySerializers.serialize(goal);
    return collectionGoalOfCurrentUser().document(goal.goalId).setData(data);
  }

  static Future<bool> goalListContains(String challengeId) async {
    DocumentSnapshot doc =
        await collectionGoalOfCurrentUser().document(challengeId).get();
    return doc.exists;
  }

  static Future<bool> changeName(String name) async {
    await collectionAccount()
        .document(_account.accountId)
        .setData({name: name}, merge: true);
    return null;
  }

  static Future generateDownload() {
    collectionDataRequestsOf(_account.accountId).document();
    // TODO - create method implantation
    return null;
  }

  static Future<bool> deleteAccount() async {
    try {
      await Auth.firebaseUser.delete();
      print("Deletion success!");
      return true;
    } catch (error) {
      print("Error in deleteAccount()!\n$error");
      return false;
    }
  }

  static Future<List<LogEntry>> getGoalLogs(String goalId) async {
    QuerySnapshot snapshots =
        await collectionGoalLogEntriesOfCurrentUser(goalId).getDocuments();
    return snapshots.documents.map((DocumentSnapshot s) {
      print(s.data);
      return mySerializers.deserializeWith(LogEntry.serializer, s.data);
    }).toList();
  }

  static getStorageReferencePost(String accountId, String postFilename) {
    return FirestoreAPI.storage
        .ref()
        .child('user')
        .child(accountId)
        .child(postFilename);
  }

  static getQuestionnaireStorageReference(String filePath) {
    return FirestoreAPI.storage
        .getReferenceFromUrl("gs://z-goals.appspot.com/quiz/$filePath");
  }

  static uploadBFI(Map<String, double> map) {
    print("Upload BFI" + map.toString());
    collectionAccount()
        .document(_account.accountId)
        .setData({"bfiTaken": true}, merge: true);
    collectionAccount()
        .document(_account.accountId)
        .collection("questionnaire")
        .document("bfi")
        .setData(map);
  }

  static void registerReminder(
      {int id,
      String goalId,
      GoalCategory goalCategory,
      Timestamp timeCreated,
      Timestamp timeToRemind,
      String day,
      String type}) {
    Reminder r = Reminder((ReminderBuilder b) => b
      ..id = id
      ..goalId = goalId
      ..goalCategory = goalCategory
      ..timeCreated = timeCreated
      ..timeToRemind = timeToRemind
      ..timeCanceled = null
      ..canceled = false
      ..day = day
      ..type = type);

    Map<String, dynamic> data = mySerializers.serialize(r);
    collectionAccount()
        .document(_account.accountId)
        .collection("reminders")
        .document(id.toString())
        .setData(data);
  }

  static Stream<QuerySnapshot> getReminderStream(String goalId) {
    return collectionAccount()
        .document(_account.accountId)
        .collection("reminders")
        .where("goalId", isEqualTo: goalId)
        .where("canceled", isEqualTo: false)
        //.orderBy("timeToRemind", descending: true)
        .snapshots();
  }

  static void cancelReminder(int id) {
    print("canceling");

    var data = {"timeCanceled": Timestamp.now(), "canceled": true};

    collectionAccount()
        .document(_account.accountId)
        .collection("reminders")
        .document(id.toString())
        .setData(data, merge: true);
  }

  static Stream<List<Quiz>> getQuizzes() {
    return _inst
        .collection("quiz")
        .where("ready", isEqualTo: true)
        .snapshots()
        .map((QuerySnapshot qs) {
      print("Quizzes: " + qs.documents.length.toString());
      print("Quizzes isEmpty: " + qs.documents.isEmpty.toString());
      return qs.documents.map((DocumentSnapshot ds) {
        print(ds.data.toString());
        Quiz quiz = mySerializers.deserializeWith(Quiz.serializer, ds.data);
        print("Quiz title: " + quiz.title);
        return quiz;
      }).toList();
    });
  }

  static Stream<List<Question>> getNetworkQuizQuestions(String quizId) {
    return _inst
        .collection("quiz")
        .document(quizId)
        .collection("questions")
        .snapshots()
        .map((qs) {
      print("Questions: " + qs.documents.length.toString());
      List<Question> questions = qs.documents.map((ds) {
        print(ds.data.toString());
        Question quiz =
            mySerializers.deserializeWith(Question.serializer, ds.data);
        print("Question question: " + quiz.question);
        return quiz;
      }).toList();

      print("Questions after map: ${questions.length}");
      return questions;
    });
  }

  static Future uploadResponse(List<QuestionData> qstData) async {
/*    DocumentSnapshot snapshot = await collectionAccount()
        .document(_account.accountId)
        .collection("questionnaire")
        .document("bfi")
        .get();*/

    Map<String, dynamic> data = {
      "accountId": account.accountId,
      "quizId": qstData[0].quizId,
      "questions": []
    };

    List<dynamic> entries = [];
    for (int i = 0; i < qstData.length; i++) {
      QuestionData dataEntry = qstData[i];

      entries.add({
        "quizId": dataEntry.quizId,
        "questionId": dataEntry.questionId,
        "likertPoints": dataEntry.likertPoints,
        "question": dataEntry.question,
        "category": dataEntry.category,
        "fileName": dataEntry.fileName,
        "scoringReversed": dataEntry.scoringReversed,
        "score": dataEntry.score,
        "labels": dataEntry.labels,
        "freeText": dataEntry.freeText,
      });
    }
    data["questions"] = entries;

    // Record the response
    await _inst
        .collection("quiz")
        .document(qstData[0].quizId)
        .collection("responses")
        .document(account.accountId)
        .setData(data);

    // Set questionnaire as taken in the account document
    DocumentSnapshot questionnaire =
        await _inst.collection("quiz").document(qstData[0].quizId).get();

    String tag = questionnaire.data["tag"];
    AccountBuilder builder = account.toBuilder();
    bool changed = false;
    if (account.questionnairesTaken == null) {
      changed = true;
      builder.questionnairesTaken = ListBuilder([tag]);
    } else {
      List<String> questionnairesTaken = account.questionnairesTaken.toList();
      if (!questionnairesTaken.contains(tag)) {
        changed = true;
        builder.questionnairesTaken =
            ListBuilder(questionnairesTaken..add(tag));
      }
    }

    if (changed) {
      _account = builder.build();
      Map<String, dynamic> accountData = mySerializers.serialize(_account);
      await collectionAccount()
          .document(_account.accountId)
          .setData(accountData);
    }
  }

  static Future createUser(String name) {
    return collectionAccount().document(Auth.user().uid).setData({
      "accountId": Auth.user().uid,
      "accountPictureUrl": "/user/profileimg.jpg",
      "name": name,
      "nameLowerCase": name.toLowerCase(),
      "friendCount": 0,
      "bio": "",
      "nickname": "",
      "goalsCreated": 0,
      "goalsCompleted": 0,
      "postsCreated": 0,
      "socialPoints": 0,
      "activityPoints": 0,
      "creativityPoints": 0,
      "created": Timestamp.now()
    });
  }

  static Future submitFeedback(String feedback) {
    return _inst.collection("feedback").document(Uuid().v1()).setData({
      "accountId": _account.accountId,
      "feedback": feedback,
      "timestamp": Timestamp.now()
    });
  }

  static Future postMessage(Map<String, dynamic> message) {
    return _inst.collection("onLaunch").document(Uuid().v1()).setData(message);
  }

  static Future deleteComment(Post post, Comment comment) async {
    await collectionCommentOf(post.goal.account.accountId, post.postId)
        .document(comment.commentId)
        .delete();
  }

  static Future deleteChallenge(Challenge challenge) async {
    if (challenge.creatorId == _account.accountId) {
      return await collectionChallenge()
          .document(challenge.challengeId)
          .delete();
    } else {
      return null;
    }
  }

  static Future<String> getWinners() async {
    return (await _inst.collection("winners").document("winners").get())
        .data["winners"];
  }

  static Stream<bool> getContestConsent() {
    return collectionAccount()
        .document(_account.accountId)
        .snapshots()
        .map((snapshot) => snapshot.data["contestConsent"]);
  }

  static void updateContestConsent(bool val) async {
    return (await collectionAccount().document(_account.accountId).setData(
        {"contestConsent": val, "accountId": account.accountId},
        merge: true));
  }

  static addQuestions(String questionnaire, int questionsToGenerate) async {
    DocumentReference questionnaireReference =
        _inst.collection("quiz").document(questionnaire);

    DocumentSnapshot questionnaireSnapshot = await questionnaireReference.get();
    if (!questionnaireSnapshot.exists) {
      questionnaireReference.setData({
        "description": "Contains general questions about you",
        "quizId": "$questionnaire",
        "ready": false,
        "tag": "TagFor$questionnaire",
        "title": "Questionnaire $questionnaire",
      });
    }

    CollectionReference questionCollection =
        questionnaireReference.collection("questions");

    int docs = (await questionCollection.getDocuments()).documents.length;
    print(docs.toString());
    for (int i = (docs ?? 0) + 1; i <= questionsToGenerate; i++) {
      questionCollection.document("q$i").setData({
        "category": "unset",
        "fileName": "", // $questionnaire/qst$i.png
        "labels": ["Strongly\nDisagree", "Strongly\nAgree"],
        "likertPoints": 5,
        "numbersVisible": false,
        "question": "Question?",
        "questionId": "q$i",
        "quizId": "$questionnaire",
        "scoringReversed": false,
        "isLikert": true,
        "isFreeText": true,
      });
    }
  }
}
