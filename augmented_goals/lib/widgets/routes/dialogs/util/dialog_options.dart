import 'package:augmented_goals/widgets/routes/dialogs/confirm_dialog.dart';
import 'package:augmented_goals/widgets/routes/dialogs/util/dialog_button.dart';
import 'package:flutter/material.dart';

class DialogOptions extends StatelessWidget {
  final VoidCallback onSubmit;
  final bool canSubmit;
  final String submitText;

  final VoidCallback onCancel;
  final String cancelText;

  final VoidCallback onSeriousAction;
  final String seriousActionText;

  const DialogOptions({Key key, this.onSubmit, this.onCancel, this.onSeriousAction, this.submitText = "Submit", this.cancelText = "Cancel", this.seriousActionText = "Delete", this.canSubmit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        DialogButton(
            text: "Delete",
            onPressed: () async {
              //widget.bloc.deleteGoal(widget.document.documentID);
              await showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                        text: "Are you sure you want to delete this goal?",
                        title: "Confirm Delete",
                        onConfirm: () async {
                          onSeriousAction();
                          Navigator.pop(context);
                        },
                      ));
            }),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                DialogButton(
                  text: cancelText,
                  onPressed: () {
                    if(onCancel != null) onCancel();
                    return Navigator.pop(context);
                  },
                ),
                DialogButton(
                  text: submitText,
                  bgColor: Theme.of(context).colorScheme.secondaryVariant,
                  onPressed: () async {
                    if (canSubmit) {
                      onSubmit();
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
