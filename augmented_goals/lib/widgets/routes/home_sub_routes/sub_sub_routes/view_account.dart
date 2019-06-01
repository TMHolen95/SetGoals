import 'package:augmented_goals/blocs/view_account.dart';
import 'package:augmented_goals/widgets/util/go_back_button.dart';
import 'package:augmented_goals/widgets/util/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewAccount extends StatefulWidget{
  final String accountId;

  const ViewAccount({Key key, this.accountId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewAccountState();

}

class _ViewAccountState extends State<ViewAccount>{
  ViewAccountBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ViewAccountBloc(widget.accountId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: GoBackButton(),
        title: Text("View Account"),
      ),
      body: ViewProfile(bloc: bloc,),
    );
  }

}