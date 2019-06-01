
import 'package:augmented_goals/blocs/legal.dart';
import 'package:augmented_goals/widgets/util/url_text.dart';
import 'package:flutter/material.dart';

class DataRequest extends StatelessWidget {
  final LegalBloc bloc;
  final LegalState state;

  const DataRequest(this.bloc, this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        leading: Icon(Icons.file_download),
        title: Text("Request Personal Data"),
        children: <Widget>[
          Text(
              "If you need to know what data that is stored on you in the database feel free to request it by sending a mail to me"),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: UrlText(text: "tormartin.holen@gmail.com", url: "mailto:tormartin.holen@gmail.com?subject=Personal%20Date%20Request&body=Personal%20Data%20Request",),
          ),
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedIconButton(
                iconData: Icons.file_download,
                text: "Download Data",
                onTap: () => ConfirmDialog(
                    text:
                    "Are you sure you need and want to download this data?\n${state.name}",
                    onConfirm: () {
                      Navigator.pop(context);
                      return bloc.downloadData(state);
                    })),
          ),*/
        ],
      ),
    );
  }
}

