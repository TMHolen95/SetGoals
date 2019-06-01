import 'package:augmented_goals/blocs/legal.dart';
import 'package:augmented_goals/widgets/routes/dialogs/confirm_dialog.dart';
import 'package:augmented_goals/widgets/util/rounded_icon_button.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends StatelessWidget {
  final LegalBloc bloc;
  final LegalState state;

  const DeleteAccount(this.bloc, this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
          leading: Icon(Icons.delete_forever),
          title: Text("Right to be Forgotten"),
          children: <Widget>[
            Text(
                "If you want to delete your account you can do so here, however beware that if you delete it it can not be undone, it is a final decition. All data about your acount will be wiped!"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedIconButton(
                  bgColor: Colors.redAccent,
                  iconData: Icons.delete_forever,
                  text: "Delete Account",
                  onTap: () => showDialog(
                      context: context,
                      builder: (builder) => ConfirmDialog(
                        title: "Confirm: Delete Account?",
                          text:
                              "Are you sure you want to eradicate and obliterate your account into oblivion?",
                          onConfirm: () async {
                            print("onConfirmTriggered");
                            await bloc.deleteAccount(state);

                          }))),
            ),
            Text(state.deletionMessage, style: TextStyle(color: Colors.red),)
          ]),
    );
  }
}
