import 'package:augmented_goals/util/firestore_api.dart';
import 'package:flutter/material.dart';

class ViewContestRules extends StatefulWidget {
  @override
  _ViewContestRulesState createState() => _ViewContestRulesState();
}

class _ViewContestRulesState extends State<ViewContestRules> {

  bool myConsent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contest Rules"),
        leading: CloseButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Rules:", style: Theme.of(context).textTheme.title,),
              ),
              Text("You can qualify to the prize draw by completing all the questionnaires, but note that "
                  "not all the questionnaires are published yet, These will be gradually published before the prize draw closes. If all are completed "
                  "you have a chance to win one of five gift card. You have to be "
                  "18 years or older to participate in this prize draw, and reside within Norway. Winners will be randomly selected. "
                  "A participant can be disqualified if the response to the questionnaires is not authentic."
                  "\n\n"

                  "The five winners will be contacted by email where they can choose their "
                  "prize, either a 200 kr gift card at CC (the shopping mall "
                  "in gjøvik) or a 25\$ gift card at Amazon. The prizes can "
                  "not be substituted for cash. \n\nThe winners will have 2 days "
                  "to reply to the mail. A new winner will be selected if no reply is received.\n\n"
                  "The prize draw will close at 19.05.19 no longer accepting new participants, "
                  "and winners will be announced at 05.06.19. Winners do consent that their names stated"
                  " can be displayed in the winner section below. The results will be visible to approximately 18.06.19.\n\n"
                  "This prize draw is NOT in any way affiliated to Apple, Google, or any other third party."
                  " The prize draw is entirely sponsored by Tor-Martin Holen. "

              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Consent to Rules", style: Theme.of(context).textTheme.title,),
              ),
              Text("Participants have to consent to these rules to participate in this prize draw. "
                  "Tap the checkbox below to consent, you can tap it again to "
                  "withdraw your consent as well."),
              StreamBuilder(
                  stream: FirestoreAPI.getContestConsent(),
                  builder: (context, snapshot) {
                    bool consent = snapshot.data;
                    snapshot.hasData ? myConsent = consent : myConsent = false;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                            value: myConsent,
                            onChanged: (val) => setState(() {
                              myConsent = val;
                              FirestoreAPI.updateContestConsent(val);
                            }),
                        ),
                        Text(myConsent
                            ? "I have consented to the rules"
                            : "I have not consented to the rules")
                      ],
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Winners:", style: Theme.of(context).textTheme.title,),
              ),

              FutureBuilder<String>(
                  future: FirestoreAPI.getWinners(),
                  initialData: "",
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshot.data ?? "announced at 05.06.19"),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
