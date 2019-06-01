import 'package:augmented_goals/data_classes/goal.dart';
import 'dart:io';

import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/data_classes/quiz.dart';
import 'package:augmented_goals/enums.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:augmented_goals/widgets/content_creation/log_data.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/app_bar-routes/feedback_form.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/accept_friends.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/admin/view_reports.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/answer_network_quiz.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/create_reminder.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/network_quiz.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/update_profile_image.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/view_account.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/view_contest_rules.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/view_full_post.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/view_goal_posts.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/view_logs.dart';
import 'package:flutter/material.dart';

abstract class AppNavigator {
  /// Use to reduce the amount of code for navigation in the app.
  static Future<T> pushRoute<T extends Object>(
      BuildContext context, Widget widget) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  static bool alreadyLaunched = false;

  /// Only set one of the optional parameters to true!
  static Future handleMessage(context, Map<String, dynamic> message,
      {bool onResume = false,
      bool onLaunch = false,
      bool onMessage = false}) async {
    String type;
    String accountId;
    String documentRef;
    print("appNavigation: executing");
    print("appNavigation: message - ${message.toString()}");
    bool isIOS = Platform.isIOS;
    if (onMessage) {
      type = isIOS ? message['type'] : message['data']['type'];
      accountId = isIOS ? message['accountId'] : message['data']['accountId'];
      documentRef =
          isIOS ? message['documentRef'] : message['data']['documentRef'];
    } else if (onResume) {
      type = message['type'];
      accountId = message['accountId'];
      documentRef = message['documentRef'];
    } else if (onLaunch) {
      type = message['type'];
      accountId = message['accountId'];
      documentRef = message['documentRef'];
      print("appNavigation: onLaunch is executing!");
/*        type = isIOS ? message['type'] : message['data']['type'];
        accountId = isIOS ? message['accountId'] : message['data']['accountId'];
        documentRef =
        isIOS ? message['documentRef'] : message['data']['documentRef'];*/
    }
    if ((onMessage) || (onResume) || (onLaunch && !alreadyLaunched)) {
      if (onLaunch) {
        alreadyLaunched = true;
      }
      Future.delayed(Duration(milliseconds: 50)).then((val) async {
        print("type: " + type);
        if (type == 'comment') {
          // TODO - Go to post.
          Post post = await FirestoreAPI.getPost(accountId, documentRef);
          pushRoute(context, ViewFullPost(post: post));
          print("appNavigation: should show full post!");
        } else if (type == 'friendRequestReceived') {
          pushRoute(context, AcceptFriends());
          print("appNavigation: should show accept friends!");
        } else if (type == 'friendRequestAccepted') {
          // TODO - go to new friend profile
          print("appNavigation: should show view account!");
          pushRoute(context, ViewAccount(accountId: accountId));
        } else if (type == 'reportChallenge') {
          pushRoute(
              context,
              ViewReports(
                type: ReportType.Challenge,
              ));
          print("appNavigation: should show reported challenges!");
        } else if (type == 'reportComment') {
          pushRoute(
              context,
              ViewReports(
                type: ReportType.Comment,
              ));
          print("appNavigation: should show reported comments!");
        } else if (type == 'reportPost') {
          pushRoute(
              context,
              ViewReports(
                type: ReportType.Post,
              ));
          print("appNavigation: should show reported posts!");
        }
      });
    }
  }

  static Future account(BuildContext context, String accountId) =>
      pushRoute(context, ViewAccount(accountId: accountId));

  static Future goalPosts(BuildContext context, Goal goal) =>
      pushRoute(context, ViewGoalPosts(goal: goal));

  static Future fullPost(BuildContext context, Post post) =>
      pushRoute(context, ViewFullPost(post: post));

  static Future goalLogging(BuildContext context, Goal goal) =>
      pushRoute(context, GoalLogging(goal: goal));

  static viewGoalLogs(BuildContext context, Goal goal) =>
      pushRoute(context, ViewLogs(goal: goal));

  static login(BuildContext context, String message) =>
      Navigator.pushNamed(context, '\login', arguments: {message: message});

  static createReminder(BuildContext context, Goal goal) =>
      pushRoute(context, CreateReminder(goal: goal));

  static answerQuiz(BuildContext context, Quiz quiz) =>
      pushRoute(context, AnswerQuiz(quiz));

  static viewQuizzes(BuildContext context) => pushRoute(context, NetworkQuiz());

  static feedback(BuildContext context) {
    pushRoute(context, FeedbackForm());
  }

  static updateProfileImage(BuildContext context) {
    pushRoute(context, UpdateProfileImage());
  }

  static viewContestRules(BuildContext context) {
    pushRoute(context, ViewContestRules());
  }
}
