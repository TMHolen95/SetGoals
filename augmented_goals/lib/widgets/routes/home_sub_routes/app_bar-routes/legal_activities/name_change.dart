
import 'package:augmented_goals/blocs/legal.dart';
import 'package:augmented_goals/widgets/util/url_text.dart';
import 'package:flutter/material.dart';

class NameCorrection extends StatelessWidget {
  final LegalBloc bloc;
  final LegalState state;

  const NameCorrection(this.bloc, this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        leading: Icon(Icons.edit),
        title: Text("Correct Personal Data"),
        children: <Widget>[
          /*Text(
              "If your name is wrong you may change it here. Note that you can only do this once every month months."),
          TextField(
            keyboardType: TextInputType.text,
            onChanged: (text) => bloc.updateName(state, text),

            controller: TextEditTools.cursorAtEnd(state.name),
            decoration: TextEditTools.defaultDecoration("New Name"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedIconButton(
                iconData: Icons.edit,
                text: "Change Name",
                onTap: () async {
                  print("Tapped");
                  await showDialog(context: context, builder: (context){
                      return ConfirmDialog(
                      title: "Name Change",
                      text:
                      "Are you sure you want to change your name to: \"${state.name}\"",
                      onConfirm: () {
                        Navigator.pop(context);
                        return bloc.changeName(state);
                      });
                  });

                }),
          ),*/
          Text("Personal data is wrong contact:"),
          UrlText(text: "tormartin.holen@gmail.com", url: "mailto:tormartin.holen@gmail.com?subject=Personal%20Data%20Correction"),
          Padding(padding: EdgeInsets.all(8),)
        ],
      ),
    );
  }
}
