import 'package:augmented_goals/blocs/legal.dart';
import 'package:augmented_goals/widgets/help_sections/information_letter.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/app_bar-routes/legal_activities/delete_account.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/app_bar-routes/legal_activities/download_data.dart';
import 'package:augmented_goals/widgets/routes/home_sub_routes/app_bar-routes/legal_activities/name_change.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:flutter/material.dart';

class ViewLegal extends StatefulWidget {
  @override
  _ViewLegalState createState() => _ViewLegalState();
}

class _ViewLegalState extends State<ViewLegal> {
  LegalBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = LegalBloc();
  }


  Widget consent(LegalBloc bloc, LegalState state){
    return ExpansionTile(
      title: IconTextTile(iconData: Icons.supervised_user_circle, text:"Consent"),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("If you want to withdraw your consent for participating in this app-based study you can do so by deleting your account under \"Right to be Forgotten\"."),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("\The information letter you agreed to when signing in can be seen below"),
        ),
        InformationLetter(),
        DeleteAccount(bloc, state),
      ],
    );
  }

  Widget gdpr(LegalBloc bloc, LegalState state){
    return ExpansionTile(
      title: IconTextTile(iconData: Icons.gavel, text:"GDPR - Your Rights"),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("GDPR provides you with certain rights, such as to have personal information corrected. The option to request all data stored about you. In addition to having the option to be erased from the service if requested."),
        ),
        NameCorrection(bloc, state),
        DataRequest(bloc, state),
        DeleteAccount(bloc, state),
      ],
    );
  }

  Widget thirdParty(LegalBloc bloc, LegalState state){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ExpansionTile(title: IconTextTile(iconData: Icons.library_books, text: "Application and third party licenses",), children: <Widget>[
          RaisedButton(onPressed: () => showLicensePage(context: context, applicationName: "Z-Goals",), child: Text("Show Licenses"),)
        ],),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: StreamBuilder<Object>(
              initialData: bloc.initial(),
              stream: bloc.legalState,
              builder: (context, snapshot) {
                LegalState state = snapshot.data;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    consent(bloc, state),
                    gdpr(bloc, state),
                    thirdParty(bloc, state),
                  ],
                );
              }),
        ));

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text("Legal Information"),
      ),
      body: body,
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}

