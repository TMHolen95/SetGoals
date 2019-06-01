import 'package:augmented_goals/blocs/network_quiz.dart';
import 'package:augmented_goals/data_classes/quiz.dart';
import 'package:augmented_goals/util/appNavigation.dart';
import 'package:flutter/material.dart';

class NetworkQuiz extends StatefulWidget {
  @override
  _NetworkQuizState createState() => _NetworkQuizState();
}

class _NetworkQuizState extends State<NetworkQuiz> {
  NetworkQuizBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = NetworkQuizBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questionnaires"),
        leading: CloseButton(),
      ),
      body: StreamBuilder<List<Quiz>>(
          stream: bloc.stream,
          builder: (BuildContext context, AsyncSnapshot<List<Quiz>> snapshot) {
            List<Quiz> data = snapshot.data;
/*            List<DocumentSnapshot> ds =snapshot.data.documents;
            List<Quiz> data = ds.map((d) => mySerializers.deserializeWith(Quiz.serializer, d.data)).toList();*/

            print("Quiz Data: " + data.toString());
            if (!snapshot.hasData) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Loading..."),
                  ),
                ],
              ));
            }
            if (data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("No questionnaires yet, please come back later.", textAlign: TextAlign.center,)
                  ],
                ),
              );
            }

            List<QuizTile> quizTiles = data
                .map((quiz) => QuizTile(
                      quiz: quiz,
                      quizTaken: bloc.checkIfTaken(quiz),
                      onClick: () => AppNavigator.answerQuiz(context, quiz),
                    ))
                .toList();

            return ListView(
              children: quizTiles,
            );
          }),
    );
  }
}

class QuizTile extends StatelessWidget {
  final Quiz quiz;
  final VoidCallback onClick;
  final bool quizTaken;

  const QuizTile({Key key, this.quiz, this.onClick, this.quizTaken = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onClick,
      title: Text(quiz.title),
      subtitle: Text(quiz.description),
      trailing: quizTaken ? Icon(Icons.check, color: Colors.green,): Icon(Icons.check_box_outline_blank),
    );
  }
}
