import 'package:flutter/material.dart';

class InformationLetter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text("Information Letter"), children: <Widget>[
      Container(
        height: 250,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: "\nResearch Participation", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nThis is an inquiry about participation in a research project where the main purpose is to evaluate if the user experience with various software features is perceived differently with users of different personality types. In this letter, we will give you information about the purpose of the project and what your participation will involve."),
                    TextSpan(text: "\n\nPurpose of the project", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nThe purpose of this project is to evaluate if users of various personality types have different preferences for what software features they like and dislike. In particular, the project will try to evaluate this through categorizing users by their personality type (with the BFI-44 model).  It will be conducted through an in-app test, with in-app questions. The project is done as part of a master’s thesis, and the scope of the project is from 07.01.2019 to 18.06.2019. However, the actual testing with users will only last around a month when the app testing begins, before the analysis of user data starts."),
                    TextSpan(text: "\n\nWho is responsible for the research project?", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nThe Norwegian University of Science and Technology (NTNU) is the institution responsible for the research project. However, Tor Martin Holen is responsible for the legality and the publishing of the application."),
                    TextSpan(text: "\n\nWhy are you being asked to participate?", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nYou have been requested to participate since you either found the application through online services (such as Google Adwords and Amazon Mechanical Turk), or you have been randomly requested in-person or messaged by the project leader to participate, or your friends may have been recruited through the previously mentioned methods and want you to join. There are no specific selection criteria for the study, yet you may be more likely to receive a request if you know the project lead. The number of participants that will be asked is not known at the time. However, as a minimum estimate, I believe 30-100 participants should be reasonable to expect. Hopefully, 100-999 will participate."),
                    TextSpan(text: "\n\nWhat does participation involve for you?", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nBy taking part in this project you agree to try out an application, how much you use it is entirely up to you, note that you may receive notifications on your phone. The testing goes over a few weeks, but the application is available after this period as well. You will receive some questions in the application from time to time about what features you find motivating and provides a good user experience. This  applies to all user groups regardless of how you were recruited."),
                    TextSpan(text: "\n\nParticipation is voluntary", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nParticipation in the project is voluntary. If you chose to participate, you can withdraw your consent at any time without giving a reason. All information about you will then be made anonymous. There will be no negative consequences for you if you chose not to participate or later decide to withdraw."),
                    TextSpan(text: "\n\nYour personal privacy – how we will store and use your personal data", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\tWe will only use your personal data for the purpose(s) specified in this information letter. We will process your personal data confidentially and in accordance with data protection legislation (the General Data Protection Regulation and Personal Data Act)."),
                    TextSpan(text: "\n\tThe only person with direct access to all data in the application is Tor Martin Holen."),
                    TextSpan(text: "\n\tYour email address is never shared in the application. Your account is only discoverable if a person already knows your name or is a friend of a friend and views that person’s friendlist, however, to see more data (public goals and posts) friend requests must have been sent and accepted first."),
                    TextSpan(text: "\n\tNote that the data is stored in the cloud service Firebase, on a server in western-europe."),
                    TextSpan(text: "\n\tData that will be processed will be extracted from the Firebase database and kept separate without personal data or identifiers on a private computer."),
                    TextSpan(text: "\n\nThe data that will be published will not contain data that make it possible to identify individuals that have participated in this study."),
                    TextSpan(text: "\n\nWhat will happen to your personal data at the end of the research project?", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nThe project is scheduled to end 18.06.19, and around that time the data collected will be deleted."),
                    TextSpan(text: "\n\nYour rights", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nSo long as you can be identified in the collected data, you have the right to:"),
                    TextSpan(text: "\n\tAccess the personal data that is being processed about you"),
                    TextSpan(text: "\n\tRequest that your personal data is deleted"),
                    TextSpan(text: "\n\tRequest that incorrect personal data about you is corrected/rectified"),
                    TextSpan(text: "\n\tReceive a copy of your personal data (data portability), and"),
                    TextSpan(text: "\n\tSend a complaint to the Data Protection Officer or The Norwegian Data Protection Authority regarding the processing of your personal data"),
                    TextSpan(text: "\n\nWhat gives us the right to process your personal data?", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nWe will process your personal data based on your consent."),
                    TextSpan(text: "\n\nBased on an agreement with the Norwegian University of Science and Technology (NTNU), NSD – The Norwegian Centre for Research Data AS has assessed that the processing of personal data in this project is in accordance with data protection legislation."),
                    TextSpan(text: "\n\nWhere can I find out more?", style: Theme.of(context).textTheme.title),
                    TextSpan(text: "\n\nIf you have questions about the project or want to exercise your rights, contact:"),
                    TextSpan(text: "\n\tThe project lead: Tor Martin Holen (tormartin.holen@gmail.com , +47 913 67 954)"),
                    TextSpan(text: "\n\tNTNUs Data Protection Officer: Thomas Helgesen (thomas.helgesen@ntnu.no, +47 930 79 038)"),
                    TextSpan(text: "\n\tThe project’s supervisor is Mariusz Nowostawski"),
                    TextSpan(text: "\n\tNSD – The Norwegian Centre for Research Data AS, by email: (personverntjenester@nsd.no) or by telephone: +47 55 58 21 17.\n\n"),

                  ],
                  style: TextStyle(color: Colors.black)),
            ),
          ),
        ),
      ),
    ]);
  }
}
