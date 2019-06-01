import 'dart:async';

import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/data_classes/comment.dart';
import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportState {
  String title;
  String submitMessage;
  String reason;
  String additionalInfo;
  String error;
  ReportState(this.title, this.submitMessage);
}

class ReportDialogBloc {
  Challenge _challenge;
  Comment _comment;
  Post _post;

  ReportState initial() {
    if (_challenge != null) {
      print("Reporting Challenge");
      return ReportState("Report challenge for: ", "Report Challenge");
    } else if (_comment != null) {
      print("Reporting Comment");
      return ReportState("Report comment for: ", "Report Comment");
    } else if (_post != null) {
      print("Reporting Post");
      return ReportState("Report post for: ", "Report Post");
    }
    return ReportState("Error", "Error");
  }

  StreamController<ReportState> _reportStateController =
      StreamController<ReportState>();

  Sink get updateReportState => _reportStateController.sink;

  Stream<ReportState> get reportState => _reportStateController.stream;

  List<String> get reportCategories => <String>[
        'Advertising',
        'Being Illegal',
        'Being Too Sexual',
        'Being Unethical',
        'Causing Harm',
        'Causing Public Disturbances',
        'Copy-Right Infringement',
        'Harassing People',
        'Spamming',
        'Other Reasons'
      ];

  /// For reporting a challenge: provide only a challenge.
  /// For reporting a comment: provide a post and a comment.
  /// For reporting a post: provide only a post.
  ReportDialogBloc({Challenge challenge, Comment comment, Post post}) {
    _challenge = challenge;
    _comment = comment;
    _post = post;
  }

  dispose() {
    _reportStateController.close();
  }

  updateReason(ReportState state, String reason) {
    state.reason = reason;
    _update(state);
  }

  updateAdditionalInfo(ReportState state, String additionalInfo) {
    state.additionalInfo = additionalInfo;
    _update(state);
  }

  _update(ReportState state) {
    updateReportState.add(state);
  }


  Future<bool> report(ReportState state) async {
    DocumentReference ref;

    if(state.reason != null){
      if (_challenge != null) {
        print("Reprot Bloc: Reporting Challenge");
        ref = FirestoreAPI.collectionChallenge().document(_challenge.challengeId);
        await FirestoreAPI.reportContent(state.reason, state.additionalInfo, ref,
            challenge: _challenge);
      } else if (_comment != null) {
        print("Reprot Bloc: Reporting Comment");
        ref = FirestoreAPI.collectionCommentOf(
            _post.goal.account.accountId, _post.postId)
            .document(_comment.commentId);

        print("Reference: " + ref.path);
        await FirestoreAPI.reportContent(state.reason, state.additionalInfo, ref, comment: _comment);
      } else if (_post != null) {
        print("Reprot Bloc: Reporting Post");
        ref = FirestoreAPI.collectionPostOf(
            _post.goal.account.accountId)
            .document(_post.postId);
        await FirestoreAPI.reportContent(state.reason, state.additionalInfo, ref,
            post: _post);
      }
      return true;
    } else {
      state.error = "Please provide a reason for this report.";
      _update(state);
      return false;
    }

  }
}
