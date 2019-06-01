import 'package:augmented_goals/blocs/modify_goal_bloc.dart';
import 'package:augmented_goals/data_classes/goal.dart';
import 'package:augmented_goals/util/text_edit_tools.dart';
import 'package:augmented_goals/widgets/routes/dialogs/util/dialog_options.dart';
import 'package:augmented_goals/widgets/util/category_picker.dart';
import 'package:augmented_goals/widgets/util/icon-text-tile.dart';
import 'package:flutter/material.dart';

class ModifyGoalDialog extends StatefulWidget {
  final Goal goal;

  const ModifyGoalDialog({Key key, this.goal}) : super(key: key);

  @override
  _ModifyGoalDialogState createState() => _ModifyGoalDialogState();
}

class _ModifyGoalDialogState extends State<ModifyGoalDialog> {
  ModifyGoalBloc bloc;
  TextEditingController controllerTitle;
  TextEditingController controllerDescription;
  ModifyGoalState state;

  @override
  void initState() {
    super.initState();
    bloc = ModifyGoalBloc();

    controllerTitle =  TextEditingController(text: widget.goal.title);

    controllerDescription =  TextEditingController(text: widget.goal.description);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.white,
            Colors.grey,
          ])),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<ModifyGoalState>(
                initialData: bloc.initial(widget.goal),
                stream: bloc.stream,
                builder: (context, snapshot) {
                  state = snapshot.data;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (text) => bloc.updateTitle(state, text),
                          controller: controllerTitle,
                          decoration: TextEditTools.defaultDecoration("Title"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLines: 4,
                          controller: controllerDescription,
                          onChanged: (text) => bloc.updateDescription(state, text),
                          decoration: TextEditTools.defaultDecoration("Description"),
                        ),
                      ),
                      Visibility(
                        visible: state.error.isNotEmpty,
                        child: Text(
                          state.error,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CategoryPicker((category) => bloc.updateCategory(state, category),
                          defaultCategory: state.category,),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Switch(value: state.public, onChanged: (val) => bloc.updatePublic(state, val)),
                              IconTextTile(iconData: state.public ? Icons.public : Icons.lock, text:state.public ? "Public" : "Private")
                            ],
                          ),
                        ),
                      ),
                      DialogOptions(
                        onSubmit: () {
                          bloc.onSubmit(state);
                        },
                        canSubmit: bloc.validated(state),
                        onSeriousAction: () => bloc.deleteGoal(),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
