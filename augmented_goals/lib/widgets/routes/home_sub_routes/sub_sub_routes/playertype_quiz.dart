import 'package:augmented_goals/util/firestore_api.dart';
import 'package:augmented_goals/widgets/util/go_back_button.dart';
import 'package:augmented_goals/widgets/util/text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlayerTypeQuiz extends StatefulWidget {
  final String accountId;

  const PlayerTypeQuiz({Key key, this.accountId}) : super(key: key);

  @override
  PlayerTypeQuizState createState() {
    return new PlayerTypeQuizState();
  }
}

class PlayerTypeQuizState extends State<PlayerTypeQuiz> {
  bool valid = false;
  String playerType = "";
  String error = "";
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Widget buildBody = Card(
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Headline("What player type are you?"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "I would be very grateful If you would take the "
              "Bartle Test. "
              "The test categorises players as achievers, explorers, "
              "socialisers, and killers. It is a model used frequently in "
              "MMORPG games. \n \nWhen you get your result, please submit"
              " your result in the input field below. Enter the test result as the four letter combination shown in the test"
              " result page, such as 'KEAS'."),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: playerType,
            validator: (value) {
              if (value.contains(RegExp("[SAEKsaek]{4}"))) {
                if (value.contains(RegExp("[Aa]{1}")) &&
                    value.contains(RegExp("[Ee]{1}")) &&
                    value.contains(RegExp("[Ss]{1}")) &&
                    value.contains(RegExp("[Kk]{1}"))) {

                    valid = true;
                    playerType = value;
                } else {
                    valid = false;
                  return "It appears you have entered duplicate characters.";
                }
              } else {
                  valid = false;
                return "Please type a valid four character combination.";
              }
            },
            autovalidate: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  const url = 'http://matthewbarr.co.uk/bartle/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text('Take Bartle Test'),
              ),
              RaisedButton(

                onPressed: () {
                  if(valid){
                    FirestoreAPI.updatePlayerType(playerType.toUpperCase());
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      error = "Please fix the textfield error before submitting";
                    });
                    return null;
                  }
                },

                child: Text("Submit"),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(error),
        )
      ]),
    );

    return Scaffold(
        key: key,
        appBar: AppBar(
          leading: GoBackButton(),
          title: Text("Player Type"),
        ),
        body: SingleChildScrollView(child: buildBody));
  }
}
