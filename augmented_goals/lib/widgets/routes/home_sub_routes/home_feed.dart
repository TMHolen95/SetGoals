import 'package:augmented_goals/blocs/post_feed.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/util/app_bar_actions.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/util/navigation_bar.dart';
import 'package:augmented_goals/widgets/util/logo_image.dart';
import 'package:augmented_goals/widgets/util/view_posts.dart';
import 'package:flutter/material.dart';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> implements AppBarActions {
  PostFeedBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PostFeedBloc();
  }

  @override
  Widget build(BuildContext context) {
    final Widget buildBody = ViewPosts(
      stream: bloc.posts,
      emptyMessage: "Posts from you and your friends will appear here.\n \n"
          "Tip 1: Friends can be added from the profile page. \n \n"
          "Tip 2: To create a post tap a goal from the goal list.\n \n"
          "Tip 3: Discover and create challenges in your local community \n\n"
          "Tip 4: There is/will be published a few questionnaires in the profile page.",
    );


    return Scaffold(
        appBar: AppBar(
          leading: HomeImage(Icons.home),
          title: Text("Home Feed"),
          actions: appBarActions(),
        ),
        bottomNavigationBar: NavigationBar(),
        body: buildBody);
  }

  @override
  List<Widget> appBarActions() {
    var homeFeedAction = <Widget>[
      /*IconButton(icon: Icon(Icons.dashboard),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/sensor");
          })*/
    ];

    AppBarActions.appendDefaultActions(homeFeedAction, context);
    return homeFeedAction;
  }


}
