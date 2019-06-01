import 'package:augmented_goals/blocs/consent_dialog.dart';
import 'package:augmented_goals/util/app_strings.dart';
import 'package:augmented_goals/widgets/help_sections/information_letter.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:flutter/material.dart';

class ConsentDialog extends StatefulWidget {
  final VoidCallback onConsent;

  const ConsentDialog({Key key, this.onConsent}) : super(key: key);

  @override
  _ConsentDialogState createState() => _ConsentDialogState();
}

class _ConsentDialogState extends State<ConsentDialog> {
  ConsentDialogBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ConsentDialogBloc();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: StreamBuilder(
      initialData: bloc.initial(),
      stream: bloc.stream,
      builder:
          (BuildContext context, AsyncSnapshot<ConsentDialogState> snapshot) {
        ConsentDialogState state = snapshot.data;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(
                  "${AppStrings.name}\nConsent Form",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title,
                ),
              ),Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Agree to all to continue to login.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              Card(
                color: Colors.cyan[50],
                child: InformationLetter(),
              ),
              ConsentElement(
                value: state.rights,
                onChanged: (val) => bloc.updateRights(state, val),
                text: "I understand the information letter and know my rights",
              ),
              ConsentElement(
                value: state.participation,
                onChanged: (val) => bloc.updateParticipation(state, val),
                text:
                    "I consent to participate in an app-based study and some questionnaires",
              ),
              ConsentElement(
                value: state.dataStorage,
                onChanged: (val) => bloc.updateDataStorage(state, val),
                text:
                    "I consent for my personal data to be stored on one of Google’s servers in the EU in western europe.",
              ),
              ConsentElement(
                value: state.dataProcessing,
                onChanged: (val) => bloc.updateDataProcessing(state, val),
                text:
                    "I consent for my data to be processed and used in a master thesis after the data have been reasonably anonymized and thus stripped of personal data.",
              ),
              ConsentButton(
                enabled: state.allowSubmit,
                onConsent: () {
                  widget.onConsent();
                  return Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    ));
  }
}

class ConsentElement extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final String text;

  const ConsentElement({Key key, this.value = false, this.onChanged, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Checkbox(value: value, onChanged: onChanged),
          Flexible(
              child: Text(
            text,
          ))
        ],
      ),
    );
  }
}

class ConsentButton extends StatelessWidget {
  final VoidCallback onConsent;
  final bool enabled;

  const ConsentButton({Key key, this.onConsent, this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: enabled ? onConsent : null,
        child: IconTextTile(
          text: "Give Consent",
          iconData: enabled ? Icons.check : Icons.error,
        ),
      ),
    );
  }
}
