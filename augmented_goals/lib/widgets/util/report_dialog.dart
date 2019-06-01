import 'package:augmented_goals/blocs/report_dialog_bloc.dart';
import 'package:augmented_goals/data_classes/challenge.dart';
import 'package:augmented_goals/data_classes/comment.dart';
import 'package:augmented_goals/data_classes/post.dart';
import 'package:augmented_goals/widgets/util/additional_info_text_field.dart';
import 'package:augmented_goals/widgets/util/dialog_header.dart';
import 'package:augmented_goals/widgets/util/rounded_icon_button.dart';
import 'package:augmented_goals/widgets/util/selectable_list.dart';
import 'package:flutter/material.dart';

/// One challenge, comment, xor post must be included.
class ReportDialog extends StatefulWidget {

  final Challenge challenge;
  final Comment comment;
  final Post post;
  final VoidCallback onReported;
  const ReportDialog({Key key, this.challenge, this.comment, this.post, this.onReported})
      : super(key: key);

  @override
  ReportDialogState createState() => new ReportDialogState();
}

class ReportDialogState extends State<ReportDialog> {

  ReportDialogBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ReportDialogBloc(
      challenge: widget.challenge,
      comment: widget.comment,
      post: widget.post,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ReportState>(
      initialData: bloc.initial(),
      stream: bloc.reportState,
      builder: (BuildContext context, AsyncSnapshot<ReportState> snapshot){
        ReportState state = snapshot.data;
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DialogHeader(
                  text: state.title),
              SelectableList(
                reportCategories: bloc.reportCategories,
                onSelection: (selection) => bloc.updateReason(state, selection),
              ),
              AdditionalInfoTextField(
                  onChanged: (updatedText) => bloc.updateAdditionalInfo(state, updatedText)),
              RoundedIconButton(
                  text: state.submitMessage,
                  iconData: Icons.report,
                  onTap: () async {
                    bool result = await bloc.report(state);
                    if(result){
                      // Dart analysis incorrectly shows this as unnecessary.
                      widget.onReported;
                      return Navigator.pop(context);
                    }
                  }),
              Visibility(
                visible: state.error != null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(state.error ?? ""),
                ),
              )
            ],
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }


}