import 'package:augmented_goals/blocs/admin/view_challenge_reports.dart';
import 'package:augmented_goals/blocs/admin/view_comment_reports.dart';
import 'package:augmented_goals/blocs/admin/view_post_reports.dart';
import 'package:augmented_goals/data_classes/serializers.dart';
import 'package:augmented_goals/enums.dart';
import 'package:augmented_goals/widgets/list_tiles/admin/report_tile_challenge.dart';
import 'package:augmented_goals/widgets/list_tiles/admin/report_tile_comment.dart';
import 'package:augmented_goals/widgets/list_tiles/admin/report_tile_post.dart';
import 'package:augmented_goals/widgets/util/action_overflow_button.dart';
import 'package:augmented_goals/widgets/util/list_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Displays reported content in a list, the type depends on the type enum inserted, either a reported challenge, comment or post.
class ViewReports extends StatefulWidget {
  final ReportType type;

  const ViewReports({Key key, this.type}) : super(key: key);

  @override
  ViewReportsState createState() {
    return new ViewReportsState();
  }
}

class ViewReportsState extends State<ViewReports> {
  var bloc;
  String title = "Reported ...!";
  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case ReportType.Challenge:
        bloc = ViewChallengeReportsBloc();
        title = "Reported Challenges";
        break;
      case ReportType.Comment:
        bloc = ViewCommentReportsBloc();
        title = "Reported Comments";
        break;
      case ReportType.Post:
        bloc = ViewPostReportsBloc();
        title = "Reported Posts";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBody = StreamBuilder<QuerySnapshot>(
        initialData: null,
        stream: bloc.content,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListHelper.prePopulatedListCases(
                  snapshot, "All Good!\nNothing to show...") ??
              ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot snapshot) {
                  var data = mySerializers.deserialize(snapshot.data);

                  return correctTile(data);
                }).toList(),
              );
        });

    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: <Widget>[
            Expanded(child: Text(title)),
            ActionOverflowOptions(),
          ],
        )),
        body: buildBody);
  }

  /// Selects the appropriate tile for the reported content.
  Widget correctTile(data){
    if (bloc is ViewCommentReportsBloc) {
      return ReportTileComment(
        comment: data,
        onAccept: () => bloc.onReportedCommentAccepted(data),
        onReject: () => bloc.onReportedCommentDeclined(data),
      );
    } else if (bloc is ViewChallengeReportsBloc) {
      return ReportTileChallenge(
        challenge: data,
        onAccept: () => bloc.onReportedChallengeAccepted(data),
        onReject: () => bloc.onReportedChallengeDeclined(data),
      );
    } else if (bloc is ViewPostReportsBloc) {
      return ReportTilePost(
        post: data,
        onAccept: () => bloc.onReportedPostAccepted(data),
        onReject: () => bloc.onReportedPostDeclined(data),
      );
    } else {
      return null; //Should not happen.
    }
  }
}
