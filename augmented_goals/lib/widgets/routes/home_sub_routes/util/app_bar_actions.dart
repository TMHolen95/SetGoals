import 'package:augmented_goals/admins.dart';
import 'package:augmented_goals/util/appNavigation.dart';
import 'package:augmented_goals/util/app_strings.dart';
import 'package:augmented_goals/util/authentication.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/app_bar-routes/add_question.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/app_bar-routes/view_legal.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/admin/report_types.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

abstract class AppBarActions {
  static void appendDefaultActions(List<Widget> actions, BuildContext context) {
    actions.add(
      PopupMenuButton(
        onSelected: (item) {
          switch (item) {
            case 'logout':
              print("Logout triggers");
              FirestoreAPI.fcmTokenRemoval().then((res) => Auth.logout());
              //After logout FirestoreAPI only works with sign in functionality.
              Navigator.pushReplacementNamed(context, "/login");
              break;
            case 'viewReports':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportTypes()),
              );
              break;
            case 'feedback':
              AppNavigator.feedback(context);
              break;
            case 'share':
              Share.share(
                  'Check out ${AppStrings.name}, '
                      'available for both Android and iOS!\n\n '
                      'Android: https://play.google.com/store/apps/details?id=com.augmentedgoals.augmentedgoals&hl=en\n\n'
                      'iOS: https://itunes.apple.com/no/app/z-goals/id1458407903?mt=8');
              break;
            case 'legal':
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewLegal()));
              break;
            case 'questions':
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddQuestion()));
              break;
          }
        },
        itemBuilder: (_) {
          List<PopupMenuItem<String>> elements = <PopupMenuItem<String>>[];
          if (Admins.isAdmin(FirestoreAPI.account.accountId)) {
            elements.add(PopupMenuItem<String>(
                child: IconTextTile(
                  iconData: Icons.live_help,
                  text: 'Add Question',
                ),
                value: 'questions'));

            elements.add(PopupMenuItem<String>(
                child: IconTextTile(
                  iconData: Icons.list,
                  text: 'View Reports',
                ),
                value: 'viewReports'));
          }
          elements.add(PopupMenuItem<String>(
              child: IconTextTile(
                iconData: Icons.mail,
                text: 'Invite Friends',
              ),
              value: 'share'));
          elements.add(PopupMenuItem<String>(
              child: IconTextTile(
                iconData: Icons.feedback,
                text: 'Feedback',
              ),
              value: 'feedback'));
          elements.add(PopupMenuItem<String>(
              child: IconTextTile(
                iconData: Icons.gavel,
                text: 'Legal',
              ),
              value: 'legal'));
          elements.add(PopupMenuItem<String>(
              child: IconTextTile(
                iconData: Icons.person_outline,
                text: 'Logout',
              ),
              value: 'logout'));

          return elements;
        },
      ),
    );
  }

  List<Widget> appBarActions();
}
