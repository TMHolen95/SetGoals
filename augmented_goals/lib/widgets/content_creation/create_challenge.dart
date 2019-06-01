import 'package:augmented_goals/blocs/create_challenge.dart';
import 'package:augmented_goals/widgets/content_creation/util/position_selection_map.dart';
import 'package:augmented_goals/widgets/help_sections/help_widget.dart';
import 'package:augmented_goals/util/strings.dart';
import 'package:augmented_goals/widgets/util/category_picker.dart';
import 'package:augmented_goals/widgets/util/text.dart';
import 'package:augmented_goals/widgets/util/toggle_icon.dart';
import 'package:flutter/material.dart';

class CreateChallengeForm extends StatefulWidget {
  CreateChallengeForm({Key key}) : super(key: key);

  @override
  _CreateChallengeState createState() => _CreateChallengeState();
}

class _CreateChallengeState extends State<CreateChallengeForm> {
  CreateChallengeBloc bloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc = CreateChallengeBloc();
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
        stream: bloc.challengeState,
        builder:
            (BuildContext context, AsyncSnapshot<ChallengeState> snapshot) {
          ChallengeState state = snapshot.data;

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
                  onPressed: () => bloc.openHelp(state))
            ],
          );

          final Widget challengeTitle = TextFormField(
            decoration: InputDecoration(labelText: "Challenge Title"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              } else {
                bloc.updateTitle(state, value);
              }
            },
          );

          final Widget challengeDescription = TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: InputDecoration(labelText: "Challenge Description"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              } else {
                bloc.updateDescription(state, value);
              }
            },
          );

          Future<void> openMapScreenForPosition() async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PositionSelectionMap()),
            ).then((pos) => bloc.setPosition(state, pos));
          }

          Widget locationDependentText() {
            return state.location == null
                ? Text("Select position")
                : Text("Position selected");
          }

          final Widget challengePosition = Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () async {
                openMapScreenForPosition();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ToggleIcon(
                    state: state.location != null,
                    isTrue: Icons.location_on,
                    isFalse: Icons.location_off,
                    purpose: TogglePurpose.ErrorValidation,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: locationDependentText(),
                  )
                ],
              ),
            ),
          );

          final Widget helpIfVisible = Visibility(
              visible: state.showHelp,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HelpWidget(
                  onCloseHelp: () => bloc.closeHelp(state),
                  title: "Help: Challenges",
                  child: Column(
                    children: <Widget>[
                      TitleText("How to create:"),
                      Text("Select a relevant category."),
                      Text("Write a proper title and description."),
                      Text("Assign it a suitable position."),
                      Text(
                        "(Otherwise, upload won't work)",
                      ),
                      TitleText("What is a Challenge?"),
                      Text(
                          "A challenge is a fun way to share interesting stuff to do with your local community."),
                      Text(
                          "When a Challenge is created you can find it on the map and add it to your goal list."),
                      TitleText("Privacy and Ethics"),
                      Text(
                          "A challenge won't show who created it so feel free to get creative."),
                      Text(
                          "However, please keep the application safe by not creating dangerous or unethical challenges.")
                    ],
                  ),
                ),
              ));

          final Widget buildBody = Stack(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        categoryAndHelp,
                        challengeTitle,
                        challengeDescription,
                        challengePosition,
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Note that the challenge will be visible for all users in the area!",
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              helpIfVisible,
            ],
          );

          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text(Strings.createChallenge),
                actions: <Widget>[
                  Visibility(
                    visible: state.allowUpload,
                    child: IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            bloc.sendChallengeIfValid(state).then((bool) {
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
