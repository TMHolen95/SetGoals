import 'package:augmented_goals/blocs/create_goal.dart';
import 'package:augmented_goals/util/strings.dart';
import 'package:augmented_goals/widgets/util/category_picker.dart';
import 'package:augmented_goals/widgets/util/dialog_header.dart';
import 'package:augmented_goals/widgets/util/text.dart';
import 'package:augmented_goals/widgets/util/toggle_icon.dart';
import 'package:flutter/material.dart';

class CreateGoalForm extends StatefulWidget {
  CreateGoalForm({Key key}) : super(key: key);

  @override
  _CreateGoalState createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoalForm> {
  CreateGoalBloc bloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc = CreateGoalBloc();
  }


  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: bloc.initial(),
        stream: bloc.goalState,
        builder: (BuildContext context, AsyncSnapshot<GoalState> snapshot) {
          GoalState state = snapshot.data;

          final Widget categoryAndHelp = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CategoryPicker((category) {
                    bloc.setCategory(state, category);
                  }),
                  Visibility(
                      visible: state.checked,
                      child: ToggleIcon(
                        state: state.category != null,
                        isTrue: Icons.done,
                        isFalse: Icons.close,
                        purpose: TogglePurpose.ErrorValidation,
                      ))
                ],
              ),
              IconButton(
                  color: Colors.grey,
                  icon: Icon(Icons.help),
                  onPressed: () => showDialog(context: context, builder: (buildContext) => GoalHelpDialog()))
            ],
          );

          final Widget goalTitle = TextFormField(
            decoration: InputDecoration(labelText: "Goal Title"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              } else {
                bloc.updateTitle(state, value);
              }
            },
          );

          final Widget goalDescription = TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: InputDecoration(labelText: "Goal Description"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              } else {
                bloc.updateDescription(state, value);
              }
            },
          );

          final Widget goalSettings = GestureDetector(
            onTap: () => bloc.updatePublic(state),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ToggleIcon(
                    state: state.public,
                    isTrue: Icons.public,
                    isFalse: Icons.public,
                    purpose: TogglePurpose.ShowEnabledIcon,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Public goal"),
                  ),
                  Switch(
                    value: state.public,
                    onChanged: (bool) => bloc.updatePublic(state),
                  )
                ],
              ),
            ),
          );

          final Widget buildBody = SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    categoryAndHelp,
                    goalTitle,
                    goalDescription,
                    goalSettings,
                  ],
                ),
              ),
            ),
          );

          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text(Strings.createGoal),
                actions: <Widget>[
                  Visibility(
                    visible: state.allowUpload,
                    child: IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            bloc.sendGoalIfValid(state).then((bool) {
                              if (bool) {
                                bloc.dispose();
                                Navigator.pop(context);
                              }
                            });
                          } else {
                            bloc.hasBeenChecked(state);
                          }
                        }),
                  )
                ],
              ),
              body: buildBody);
        });
  }
}

class GoalHelpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DialogHeader(text: "Help: Goals",),
            TitleText("Creating a goal:"),
            Text("Select a relevant category."),
            Text("Write a proper title and description."),
            Text("Choose if your goal is public."),

            TitleText("What is a Goal?"),
            Text(
                "A goal is a way to share with you friends what you want to achieve in life."),
            Text(
                "It can be anything - such as improving a skill, spending more time with friends, or learning to relax better."),

            TitleText("Privacy and Ethics"),
            Text(
                "If a goal is marked public, friends can see this goal when they visit your profile."),
            Text("If it is private, only you can see this goal, the same applies to posts on a private goal."),
          ],
        ),
      ),
    );
  }
}



