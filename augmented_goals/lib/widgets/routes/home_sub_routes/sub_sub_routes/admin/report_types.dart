import 'package:augmented_goals/enums.dart';
import 'package:augmented_goals/widgets/list_tiles/navigation_tile.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/sub_sub_routes/admin/view_reports.dart';
import 'package:flutter/material.dart';

class ReportTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget buildBody = ListView(
      children: <NavigationTile>[
        NavigationTile(
          title: "Challenge Reports",
          onTap: () {
            return Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewReports(type: ReportType.Challenge,)),
            );
          },
        ),
        NavigationTile(
          title: "Comment Reports",
          onTap: () {
            return Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewReports(type: ReportType.Comment,)),
            );
          },
        ),
        NavigationTile(
          title: "Post Reports",
          onTap: () {
            return Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewReports(type: ReportType.Post,)),
            );
          },
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Reports"),
      ),
      body: buildBody,
    );
  }
}
