import 'package:augmented_goals/blocs/quick_view_challenge.dart';
import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/widgets/routes/dialogs/confirm_dialog.dart';
import 'package:augmented_goals/widgets/util/action_overflow_button.dart';
import 'package:augmented_goals/widgets/util/dialog_header.dart';
import 'package:augmented_goals/widgets/util/report_dialog.dart';
import 'package:augmented_goals/widgets/util/scrollable_text_field.dart';
import 'package:flutter/material.dart';

class QuickViewChallenge extends StatefulWidget {
  final Challenge challenge;
  final bool makeVisible;
  final Function(Challenge) onDelete;

  const QuickViewChallenge({Key key, this.challenge, this.makeVisible, this.onDelete})
      : super(key: key);

  @override
  QuickViewChallengeState createState() {
    return new QuickViewChallengeState();
  }
}

class QuickViewChallengeState extends State<QuickViewChallenge> {
  QuickViewChallengeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: StreamBuilder<Object>(
            initialData: bloc.initial(),
            stream: bloc.acceptState,
            builder: (context, snapshot) {
              AcceptState state = snapshot.data;

              List<Widget> body;

              if (state.inGoalList == null) {
                Future.delayed(Duration(milliseconds: 50),
                    () => bloc.checkGoalList(state, widget.challenge));
                body = <Widget>[Center(child: CircularProgressIndicator())];
              }

              List<TitledAction> actions = [
                TitledAction("Report Challenge",
                    () => showReportDialog(state, context, widget.challenge))
              ];
              if (bloc.isChallengeCreator(widget.challenge)) {
                actions.add(TitledAction(
                    "Delete Challenge",
                    () => showDialog(
                        context: context,
                        builder: (builder) => ConfirmDialog(
                              title: "Delete Challenge?",
                              text:
                                  "Are you sure you want to delete the challenge?\nChallenge: ${widget.challenge.title}",
                              onConfirm: () async {
                                await bloc.deleteChallenge(widget.challenge);
                                Navigator.pop(context);
                                widget.onDelete(widget.challenge);
                              },
                            ))));
              }

              body = <Widget>[
                DialogHeader(
                  text: widget.challenge.title,
                  overflowActions: actions,
                ),
                ScrollableTextField(text: widget.challenge.description),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: FlatButton(
                      child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: state.message.isEmpty ? 0 : 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.check),
                              Text(state.message),
                            ],
                          )),
                      onPressed: () async {
                        await bloc.onChallengeAccepted(state, widget.challenge);
                        Navigator.pop(context);
                      }),
                )
              ];

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: body,
              );
            }));
  }

  showReportDialog(
      AcceptState state, BuildContext context, Challenge challenge) {
    showDialog(
        context: context,
        builder: (buildContext) => ReportDialog(
              challenge: challenge,
              onReported: bloc.onReport(state, challenge),
            ));
  }

  @override
  void initState() {
    super.initState();
    bloc = QuickViewChallengeBloc();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
